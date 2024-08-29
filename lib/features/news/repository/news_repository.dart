import 'package:dio/dio.dart';

import '../../../shared/model/api_result.dart';
import '../../../shared/provider/dio_provider.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../model/news_model.dart';

class NewsRepository {
  NewsRepository({required this.ref, required this.dio});

  final Ref ref;
  final Dio dio;

  Future<Result<List<NewsModel>>> getNews() async {
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

      if (response.statusCode == 204) {
        return Result(error: 'No data found');
      }

      if (response.statusCode != 200) {
        return Result(
            error: response.data['message'] ?? 'Something went wrong');
      } else {
        Iterable list = response.data['news']['data'];
        List<NewsModel> data = list.map((e) => NewsModel.fromJson(e)).toList();
        return Result(data: data);
      }
    } on DioException catch (e) {
      return Result(
          error: e.response?.data['message'] ?? 'Something went wrong');
    }
  }
}

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepository(
    ref: ref,
    dio: ref.read(dioProvider),
  ),
);
