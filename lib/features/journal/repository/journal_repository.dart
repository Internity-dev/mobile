import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../model/journal_model.dart';
import '../model/post_journal_model.dart';

class JournalRepository {
  JournalRepository({required this.ref, required this.dio});

  final Ref ref;
  final Dio dio;

  Future<List<JournalModel>> getJournals(int companyId) async {
    try {
      final response = await dio.get(
        '/api/journals?company=$companyId',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
        ),
      );

      Iterable list = response.data['journals'];
      List<JournalModel> data =
          list.map((e) => JournalModel.fromJson(e)).toList();

      return data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future<void> postJournal(PostJournal data) {
    return dio.put('/api/journals/${data.activityId}', data: data.toJson());
  }
}

final journalRepositoryProvider = Provider<JournalRepository>(
  (ref) => JournalRepository(
    ref: ref,
    dio: ref.read(dioProvider),
  ),
);
