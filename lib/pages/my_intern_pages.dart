import 'package:flutter/material.dart';

import '../features/vacancies/presentation/my_intern_widget.dart';

import '../features/vacancies/provider/vacancies_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../theme/colors.dart';

class MyInternPages extends HookConsumerWidget {
  const MyInternPages({super.key});
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
            await ref.refresh(myInternProvider.future);
          },
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: MyInternWidget(),
          ),
        ),
      ),
    );
  }
}
