import 'package:dio/dio.dart';
import 'package:internity/shared/provider/shared_pref_provider.dart';

import '../../shared/riverpod_and_hooks.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = 'http://192.168.8.100:8000/';
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
        error: e.response?.data['message'] ??
            'Something went wrong or Server is Bussy',
        type: e.type,
        response: e.response,
      ));
    },
    onRequest: (options, handler) async {
      final prefs = await ref.watch(sharedPrefProvider);

      if (prefs.getString('token') != null) {
        options.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
      }

      return handler.next(options);
    },
  ));

  return dio;
});
