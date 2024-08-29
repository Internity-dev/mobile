import '../../../shared/riverpod_and_hooks.dart';
import '../model/daily_activity_model.dart';
import '../repository/daily_activity_repository.dart';

final dailyActivityProvider =
    FutureProvider.autoDispose.family<DailyActivityModel, int>(
  (ref, companyId) async {
    return await ref
        .watch(dailyActivityRepositoryProvider)
        .getDailyActivity(companyId);
  },
);
