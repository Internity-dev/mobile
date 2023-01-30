import 'package:dio/dio.dart';

import '../../shared/riverpod_and_hooks.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = 'http://192.168.102.143:8000/';
  // dio.options.connectTimeout = 5000;
  // dio.options.receiveTimeout = 3000;
  return dio;
});
