import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://contactapi-o90h.onrender.com', // Replace with your API URL
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  Future<void> sendContactMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await _dio.post(
        '/contact',
        data: {
          'name': name,
          'email': email,
          'message': message,
        },
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Message sent successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        throw Exception('Failed to send message');
      }
    } on DioException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.response != null) {
        errorMessage = e.response?.data['message'] ?? 'Server error';
      } else {
        errorMessage = e.message ?? 'Network error';
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      throw Exception(errorMessage);
    }
  }
}