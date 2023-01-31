import 'package:dio/dio.dart';

import '../../shared/riverpod_and_hooks.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = 'http://172.20.4.2:8000/';
  // dio.options.connectTimeout = 5000;
  // dio.options.receiveTimeout = 3000;

  dio.interceptors.add(InterceptorsWrapper(
    onError: (DioError e, handler) {
      return handler.next(DioError(
        requestOptions: e.requestOptions,
        error: e.response?.data['message'] ?? 'Something went wrong',
        type: e.type,
        response: e.response,
      ));
    },
  ));

  return dio;
});
