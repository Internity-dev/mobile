import 'package:dio/dio.dart';
import 'package:internity/shared/provider/shared_pref_provider.dart';

import '../../shared/riverpod_and_hooks.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = 'https://admin.internity.smkn1cibinong.sch.id/';
  // dio.options.connectTimeout = const Duration(seconds: 5);
  // dio.options.receiveTimeout = const Duration(seconds: 3);
  dio.options.headers['Accept'] = 'application/json';

  dio.interceptors.add(InterceptorsWrapper(
    onError: (DioException e, handler) async {
      if (e.response?.statusCode == 401) {
        final prefs = await ref.watch(sharedPrefProvider);
        prefs.remove('token');
      }

      return handler.next(DioException(
        requestOptions: e.requestOptions,
        error: e.response?.data['message'] ??
            'Something went wrong or Server is Bussy',
        type: e.type,
        response: e.response,
        stackTrace: e.stackTrace,
        message: e.message,
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
