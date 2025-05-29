import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'https://api.docai.online';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // ==================== Auth Endpoints ====================
  static Future<http.Response> signUp(Map<String, dynamic> data) async {
    return await _post('/api/auth/signup', data);
  }

  static Future<http.Response> signIn(Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/api/auth/signin');
    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> logout() async {
    return await _post('/api/auth/logout', {});
  }

// ==================== Pet Owner Profile ====================
  static Future<http.Response> getPetOwnerProfile(String id) async {
    return await _get('/api/petOwners/profile/$id');
  }

  static Future<http.Response> updatePetOwnerProfile(
      String id, Map<String, dynamic> data) async {
    return await _put('/api/petOwners/profile/$id', data);
  }

  // ==================== Appointments ====================
  static Future<http.Response> bookAppointment(
      Map<String, dynamic> data) async {
    return await _post('/api/appointments', data);
  }

  static Future<http.Response> getOwnerAppointments(String ownerId) async {
    return await _get('/api/appointments/$ownerId');
  }

  static Future<http.Response> cancelAppointment(String id) async {
    return await _patch('/api/appointments/cancel/$id', {});
  }

  static Future<http.Response> rescheduleAppointment(
      String id, Map<String, dynamic> data) async {
    return await _patch('/api/appointments/reschedule/$id', data);
  }

  static Future<http.Response> getNextAppointment(String ownerId) async {
    return await _get('/api/appointments/next/$ownerId');
  }

  // ==================== Pet Profiles ====================
  static Future<http.Response> createPetProfile(
      Map<String, dynamic> data) async {
    return await _post('/api/petProfiles', data);
  }

  static Future<http.Response> getOwnerPets(String ownerId) async {
    return await _get('/api/petProfiles/$ownerId');
  }

  static Future<http.Response> updatePetProfile(
      String id, Map<String, dynamic> data) async {
    return await _put('/api/petProfiles/$id', data);
  }

  // ==================== Medical Records ====================
  static Future<http.Response> addMedicalRecord(
      Map<String, dynamic> data) async {
    return await _post('/api/medicalRecords', data);
  }

  static Future<http.Response> getPetMedicalRecords(String petId) async {
    return await _get('/api/medicalRecords/$petId');
  }

  // ==================== Community ====================
  static Future<http.Response> createCommunityPost(
      Map<String, dynamic> data) async {
    return await _post('/api/community', data);
  }

  static Future<http.Response> getCommunityPosts() async {
    return await _get('/api/community');
  }

  static Future<http.Response> deleteCommunityPost(String id) async {
    return await _delete('/api/community/$id');
  }

  static Future<http.Response> addComment(
      String postId, Map<String, dynamic> data) async {
    return await _post('/api/community/$postId/comment', data);
  }

  // ==================== Reviews ====================
  static Future<http.Response> addReview(Map<String, dynamic> data) async {
    return await _post('/api/reviews', data);
  }

  static Future<http.Response> getClinicReviews(String clinicId) async {
    return await _get('/api/reviews/clinic/$clinicId');
  }

  static Future<http.Response> deleteReview(String id) async {
    return await _delete('/api/reviews/$id');
  }

  // ==================== AI Assistant ====================
  static Future<http.Response> askAI(Map<String, dynamic> data) async {
    return await _post('/api/chatbot/ask', data);
  }

  // ==================== Notifications ====================
  static Future<http.Response> getUserNotifications(String userId) async {
    return await _get('/api/notifications/$userId');
  }

  static Future<http.Response> deleteNotification(String id) async {
    return await _delete('/api/notifications/$id');
  }

  // ==================== Core HTTP Methods ====================
  static Future<http.Response> _get(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.get(url, headers: headers);
  }

  static Future<http.Response> _post(String endpoint, dynamic data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> _put(String endpoint, dynamic data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.put(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> _patch(String endpoint, dynamic data) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.patch(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );
  }

  static Future<http.Response> _delete(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.delete(url, headers: await _getHeaders());
  }

  // ==================== Auth Helper ====================
  static Future<Map<String, String>> _getHeaders() async {
    final headers = {'Content-Type': 'application/json'};
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
