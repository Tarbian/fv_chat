import 'package:dio/dio.dart';
import 'package:fv_chat/data/managers/base/network_manager.dart';

class DioNetworkManager implements NetworkManager {
  final Dio _dio;

  DioNetworkManager({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      return await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      throw Exception('HTTP помилка: ${e.message}');
    }
  }
}
