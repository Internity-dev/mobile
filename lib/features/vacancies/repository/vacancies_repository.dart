import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/change_intern_date_model.dart';
import '../model/intern_regist_status_model.dart';
import '../model/my_intern_model.dart';
import '../model/recommended_vacancies_model.dart';
import '../model/vacancie_model.dart';
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
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
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
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
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
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
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
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  // Get Vacancie
  Future<VacancieModel> getVacancie(int id) async {
    try {
      final response = await dio.get('/api/vacancies/$id');

      VacancieModel data = VacancieModel.fromJson(response.data['vacancy']);

      return data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  // Apply Vacancie
  Future<void> applyVacancie(int id) async {
    await dio.post('/api/appliances', data: {'vacancy_id': id});
  }

  // Cancel Vacancie
  Future<void> cancelVacancie(int id) async {
    await dio.put('/api/appliances/$id/cancel');
  }

  // Change intern date
  Future<void> changeInternDate(int id, ChangeInternDate data) async {
    await dio.put('/api/appliances/$id/edit-date', data: data.toJson());
  }
}

final vacanciesRepositoryProvider = Provider<VacanciesRepository>(
  (ref) => VacanciesRepository(ref, ref.read(dioProvider)),
);
