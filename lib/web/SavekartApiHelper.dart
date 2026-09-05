import 'dart:convert';
import 'package:http/http.dart' as http;

class SavekartApiService {
  // Change this to your API base URL
  static const String baseUrl = 'https://mysaving.in/SavekartApi/';

  // Common headers
  static Map<String, String> _headers({
    String? token,
  }) {
    final timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Timestamp': timestamp.toString(),
      if (token != null)
        'Authorization': '$token|$timestamp',
    };
  }

  // =========================
  // GET METHOD
  // =========================

  static Future<dynamic> get(
      String endpoint, {
        String? token,
        Map<String, String>? queryParameters,
      }) async {
    try {
      Uri url = Uri.parse('$baseUrl$endpoint');

      if (queryParameters != null) {
        url = url.replace(
          queryParameters: queryParameters,
        );
      }

      final response = await http.get(
        url,
        headers: _headers(token: token),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('GET API Error: $e');
    }
  }

  // =========================
  // POST METHOD
  // =========================

  static Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? body,
        String? token,
      }) async {


    try {
      final url = Uri.parse('$baseUrl$endpoint');

      print(url.path);
      print(body.toString());

      final response = await http.post(
        url,
        headers: _headers(token: token),
        body: body ?? {},
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('POST API Error: $e');
    }
  }

  // =========================
  // RESPONSE HANDLER
  // =========================

  static dynamic _handleResponse(
      http.Response response,
      ) {
    dynamic data;

    try {
      data = jsonDecode(response.body);
    } catch (e) {
      data = response.body;
    }

    if (response.statusCode >= 200 &&
        response.statusCode < 300) {
      return data;
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: data is Map
          ? data['message']?.toString() ?? 'API Error'
          : 'API Error',
      data: data,
    );
  }
}


// =========================
// API EXCEPTION
// =========================

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  ApiException({
    required this.statusCode,
    required this.message,
    this.data,
  });

  @override
  String toString() {
    return 'ApiException($statusCode): $message';
  }
}