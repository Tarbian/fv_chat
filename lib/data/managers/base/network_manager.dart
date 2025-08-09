import 'package:dio/dio.dart';

abstract class NetworkManager {
  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  });
}
