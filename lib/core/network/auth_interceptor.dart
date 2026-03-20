//This interceptor runs before every request. It calls getToken() — a function you'll inject later from your auth state — and attaches
//the token if one exists. Keeping it as a callback means the interceptor always gets the latest token.
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String? Function() getToken;

  AuthInterceptor({required this.getToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
