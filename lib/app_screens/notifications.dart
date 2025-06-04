import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petscare/api/notifications_mobel.dart';
import 'package:petscare/api/user_service.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    final userId = await UserService.getUserId();
    if (userId == null) return;

    final url = Uri.parse(
        'https://pet-care-system-api.vercel.app/api/notifications/$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          _notifications =
              data.map((json) => NotificationModel.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      print("Error: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        body: Stack(
          children: [
            Positioned(
              left: 207,
              top: -342,
              child: Container(
                width: 399,
                height: 432,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffBAD7DF).withOpacity(0.3),
                      blurRadius: 300,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // App Bar
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const SizedBox(width: 110),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins3',
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(color: Color(0xffD9D9D9)),
                  const SizedBox(height: 15),

                  // Body
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _notifications.isEmpty
                            ? const Center(
                                child: Text('No notifications found.'))
                            : ListView.builder(
                                itemCount: _notifications.length,
                                itemBuilder: (context, index) {
                                  final item = _notifications[index];
                                  return ListTile(
                                    leading: const Icon(Icons.notifications),
                                    title: Text(item.title),
                                    subtitle: Text(item.message),
                                    trailing: Text(
                                      "${item.timestamp.toLocal()}"
                                          .split(' ')[0],
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
