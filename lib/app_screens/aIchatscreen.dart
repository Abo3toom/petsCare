import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petscare/api/api_service.dart';
import 'package:petscare/api/user_service.dart';

class AIChatScreen1 extends StatefulWidget {
  @override
  _AIChatScreenState createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen1> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final message = _messageController.text.trim();
    setState(() {
      _messages.add(
          {'text': message, 'sender': 'user', 'timestamp': DateTime.now()});
      _isLoading = true;
    });
    _messageController.clear();
    _scrollToBottom();

    try {
      final userId = await UserService.getUserId();
      if (userId == null) throw Exception('User not authenticated');

      final response = await ApiService.askAI({
        'userId': userId,
        'question': message,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _messages.add({
            'text': responseData['answer'] ?? 'No response from AI',
            'sender': 'bot',
            'timestamp': DateTime.now()
          });
        });
      } else {
        _handleErrorResponse(response);
      }
    } catch (e) {
      _handleError(e.toString());
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _handleErrorResponse(http.Response response) {
    final errorMsg = response.statusCode == 401
        ? 'Session expired. Please login again.'
        : 'Error: ${response.statusCode} - ${response.reasonPhrase}';

    _handleError(errorMsg);
  }

  void _handleError(String error) {
    setState(() {
      _messages
          .add({'text': error, 'sender': 'error', 'timestamp': DateTime.now()});
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Pet Assistant'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          if (_isLoading) LinearProgressIndicator(minHeight: 1),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['sender'] == 'user';
    final isError = message['sender'] == 'error';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isError
              ? Colors.red[100]
              : isUser
                  ? Color(0xFF99DDCC)
                  : Color(0xffEDEDED),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isUser ? 12 : 0),
            topRight: Radius.circular(isUser ? 0 : 12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: TextStyle(
                color: isError
                    ? Colors.red[900]
                    : isUser
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              _formatTime(message['timestamp']),
              style: TextStyle(
                color: isError
                    ? Colors.red[900]
                    : isUser
                        ? Colors.white70
                        : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? timestamp) {
    if (timestamp == null) return '';
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildInputField() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
        top: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your question...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        style: TextStyle(fontSize: 16),
                        maxLines: null,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF99DDCC),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                      splashRadius: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
