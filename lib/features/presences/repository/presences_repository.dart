import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/post_presences_model.dart';

class PresencesRepository {
  final Ref ref;
  final Dio dio;

  PresencesRepository({required this.ref, required this.dio});

  Future<void> postPresences(PostPresencesModel data) {
    print(data.toJson());

    return Future.value();

    // return dio.put('/presences', data: data.toJson());
  }
}

final presencesRepositoryProvider = Provider<PresencesRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PresencesRepository(ref: ref, dio: dio);
});
