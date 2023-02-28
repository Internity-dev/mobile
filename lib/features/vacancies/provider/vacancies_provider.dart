import '../../../shared/riverpod_and_hooks.dart';
import '../model/vacancies_model.dart';
import '../repository/vacancies_repository.dart';

final vacanciesProvider = FutureProvider.autoDispose<List<VacanciesModel>>(
  (ref) async {
    return ref.watch(vacanciesRepositoryProvider).getVacancies();
  },
);
