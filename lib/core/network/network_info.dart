//This gives you a simple way to check connectivity before making requests.
//Repositories will use this to decide whether to return a
//NetworkFailure early.
import 'package:dio/dio.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Dio dio;

  NetworkInfoImpl(this.dio);

  @override
  Future<bool> get isConnected async {
    try {
      final response = await dio.get('https://8.8.8.8');
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
