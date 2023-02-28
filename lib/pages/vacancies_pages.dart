import 'package:flutter/material.dart';

import '../features/vacancies/presentation/vacancies_item_widget.dart';
import '../shared/riverpod_and_hooks.dart';

class VacanciesPages extends HookConsumerWidget {
  const VacanciesPages({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: const Scaffold(
        body: SingleChildScrollView(child: VacanciesItemWidget()),
      ),
    );
  }
}
