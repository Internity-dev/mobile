import 'package:dio/dio.dart';

import '../../shared/riverpod_and_hooks.dart';

final dioProvider = Provider.family<Dio, String?>((ref, token) {
  final dio = Dio();
  dio.options.baseUrl = 'http://192.168.41.143:8000/';
  // dio.options.connectTimeout = 5000;
  // dio.options.receiveTimeout = 3000;
  dio.options.headers['Accept'] = 'application/json';

  dio.interceptors.add(InterceptorsWrapper(
    onError: (DioError e, handler) {
      return handler.next(DioError(
        requestOptions: e.requestOptions,
        error: e.response?.data['message'] ?? 'Maaf Server Sedang Sibuk',
        type: e.type,
        response: e.response,
      ));
    },
  ));

  return dio;
});
