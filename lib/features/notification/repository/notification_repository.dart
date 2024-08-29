import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../model/notification_model.dart';

class NotificationRepository {
  NotificationRepository({required this.ref, required this.dio});

  final Ref ref;
  final Dio dio;

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await dio.get(
        '/api/notifications',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
        ),
      );

      Iterable list = response.data['notifications'];
      List<NotificationModel> data =
          list.map((e) => NotificationModel.fromJson(e)).toList();

      return data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepository(
    ref: ref,
    dio: ref.read(dioProvider),
  ),
);
