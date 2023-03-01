import '../../../shared/riverpod_and_hooks.dart';
import '../model/intern_regist_status_model.dart';
import '../model/my_intern_model.dart';
import '../model/recommended_vacancies_model.dart';
import '../model/vacancies_model.dart';
import '../repository/vacancies_repository.dart';

final vacanciesProvider = FutureProvider.autoDispose<List<VacanciesModel>>(
  (ref) async {
    return ref.watch(vacanciesRepositoryProvider).getVacancies();
  },
);

final recommendedVacanciesProvider =
    FutureProvider.autoDispose<List<RecommendedVacanciesModel>>(
  (ref) async {
    return ref.watch(vacanciesRepositoryProvider).getRecommendedVacancies();
  },
);

final internRegistStatusProvider =
    FutureProvider.autoDispose<List<InternRegistStatusModel>>(
  (ref) async {
    return ref.watch(vacanciesRepositoryProvider).getInternRegistStatus();
  },
);

final myInternProvider = FutureProvider.autoDispose<List<MyInternModel>>(
  (ref) async {
    return ref.watch(vacanciesRepositoryProvider).getMyIntern();
  },
);
