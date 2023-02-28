import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/vacancies_model.dart';

class VacanciesRepository {
  final Ref ref;
  final Dio dio;

  VacanciesRepository(this.ref, this.dio);

  Future<List<VacanciesModel>> getVacancies() async {
    try {
      final response = await dio.get('/api/vacancies');

      Iterable list = response.data['vacancies'];
      List<VacanciesModel> data =
          list.map((e) => VacanciesModel.fromJson(e)).toList();

      return data;
    } on DioError catch (e) {
      throw e.message;
    }
  }
}

final vacanciesRepositoryProvider = Provider.autoDispose<VacanciesRepository>(
  (ref) => VacanciesRepository(ref, ref.read(dioProvider)),
);
