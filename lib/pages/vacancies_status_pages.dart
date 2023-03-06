import 'package:flutter/material.dart';

import '../features/vacancies/presentation/vacancies_item_status_widget.dart';
import '../features/vacancies/provider/vacancies_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../theme/colors.dart';

class VacanciesStatusPages extends HookConsumerWidget {
  const VacanciesStatusPages({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(primaryTextColor),
          title: const Text(
            'Kembali',
            style: TextStyle(
              color: Color(primaryTextColor),
              fontSize: 12,
            ),
          ),
          titleSpacing: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(internRegistStatusProvider.future);
          },
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: VacanciesItemStatusWidget(),
          ),
        ),
      ),
    );
  }
}
