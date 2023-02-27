import 'package:internity/shared/riverpod_and_hooks.dart';

import '../model/news_model.dart';
import '../repository/news_repository.dart';

final newsProvider = FutureProvider.autoDispose<List<NewsModel>>((ref) async {
  try {
    final result = await ref.watch(newsRepositoryProvider).getNews();

    return result;
  } catch (e) {
    return Future.error(e);
  }
});
