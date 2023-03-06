import '../../../shared/riverpod_and_hooks.dart';
import '../model/notification_model.dart';
import '../repository/notification_repository.dart';

final notificationProvider =
    FutureProvider.autoDispose<List<NotificationModel>>((ref) async {
  return await ref.read(notificationRepositoryProvider).getNotifications();
});
