import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/intern_regist_status_model.dart';
import '../model/my_intern_model.dart';
import '../model/recommended_vacancies_model.dart';
import '../model/vacancies_model.dart';

class VacanciesRepository {
  final Ref ref;
  final Dio dio;

  VacanciesRepository(this.ref, this.dio);

  // Get vacancies list
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

  // Get recommended vacancies list
  Future<List<RecommendedVacanciesModel>> getRecommendedVacancies() async {
    try {
      final response = await dio.get('/api/vacancies/recommended');

      Iterable list = response.data['vacancies'];
      List<RecommendedVacanciesModel> data =
          list.map((e) => RecommendedVacanciesModel.fromJson(e)).toList();

      return data;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  // Get intern registration status
  Future<List<InternRegistStatusModel>> getInternRegistStatus() async {
    try {
      final response = await dio.get('/api/appliances');

      Iterable list = response.data['appliances'];
      List<InternRegistStatusModel> data =
          list.map((e) => InternRegistStatusModel.fromJson(e)).toList();

      return data;
    } on DioError catch (e) {
      throw e.message;
    }
  }

  // Get My intern data
  Future<List<MyInternModel>> getMyIntern() async {
    try {
      final response = await dio.get('/api/appliances/accepted');

      Iterable list = response.data['appliances'];
      List<MyInternModel> data =
          list.map((e) => MyInternModel.fromJson(e)).toList();

      return data;
    } on DioError catch (e) {
      throw e.message;
    }
  }
}

final vacanciesRepositoryProvider = Provider.autoDispose<VacanciesRepository>(
  (ref) => VacanciesRepository(ref, ref.read(dioProvider)),
);
