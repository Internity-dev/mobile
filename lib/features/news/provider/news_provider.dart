import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../../shared/model/api_result.dart';
import '../model/news_model.dart';
import '../repository/news_repository.dart';

final newsProvider =
    FutureProvider.autoDispose<Result<List<NewsModel>>>((ref) async {
  return await ref.watch(newsRepositoryProvider).getNews();
});
