import 'package:flutter/material.dart';
import 'package:internity/features/upload_cv/presentation/upload_cv_widget.dart';

import '../features/profile/provider/profile_provider.dart';
import '../features/vacancies/presentation/vacancies_item_widget.dart';
import '../features/vacancies/provider/vacancies_provider.dart';
import '../shared/riverpod_and_hooks.dart';

class VacanciesPages extends HookConsumerWidget {
  const VacanciesPages({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(profileProvider);

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        body: userData.when(
            data: (data) {
              if (data.resumeUrl == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    UploadCV(),
                  ],
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.refresh(vacanciesProvider.future);
                    await ref.refresh(recommendedVacanciesProvider.future);
                  },
                  child: const SingleChildScrollView(
                    child: VacanciesItemWidget(),
                  ),
                );
              }
            },
            error: (error, stack) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
