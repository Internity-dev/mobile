import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../model/news_model.dart';

class NewsRepository {
  NewsRepository({required this.ref, required this.dio});

  final Ref ref;
  final Dio dio;

  Future<List<NewsModel>> getNews() async {
    try {
      final response = await dio.get(
        '/api/news',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
        ),
      );

      Iterable list = response.data['news']['data'];
      List<NewsModel> data = list.map((e) => NewsModel.fromJson(e)).toList();

      return data;
    } on DioError catch (e) {
      throw e.message;
    }
  }
}

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepository(
    ref: ref,
    dio: ref.read(dioProvider),
  ),
);
