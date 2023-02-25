import 'package:dio/dio.dart';
import 'package:internity/shared/provider/shared_pref_provider.dart';

import '../../shared/riverpod_and_hooks.dart';

final dioProvider = Provider.family<Dio, String?>((ref, token) {
  final dio = Dio();
  dio.options.baseUrl = 'http://192.168.8.101:8000/';
  // dio.options.connectTimeout = 5000;
  // dio.options.receiveTimeout = 3000;
  dio.options.headers['Accept'] = 'application/json';

  dio.interceptors.add(InterceptorsWrapper(
    onError: (DioError e, handler) async {
      if (e.response?.statusCode == 401) {
        final prefs = await ref.watch(sharedPrefProvider);
        prefs.remove('token');
      }

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
