import 'package:dio/dio.dart';
import 'package:internity/features/daily_activity/model/daily_activity_model.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';

class DailyActivityRepository {
  final Ref ref;
  final Dio dio;

  DailyActivityRepository({required this.ref, required this.dio});

  Future<DailyActivityModel> getDailyActivity(int companyId) async {
    try {
      final response =
          await dio.get('/api/today-activities?company=$companyId');

      return DailyActivityModel.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }
}

final dailyActivityRepositoryProvider =
    Provider.autoDispose<DailyActivityRepository>((ref) {
  return DailyActivityRepository(ref: ref, dio: ref.read(dioProvider));
});
