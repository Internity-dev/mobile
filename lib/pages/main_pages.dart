import 'package:flutter/material.dart';
import 'package:internity/pages/home_pages.dart';

import '../shared/provider/bottom_bar_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../shared/widget/bottom_bar.dart';
import 'profile_pages.dart';
import 'vacancies_pages.dart';

class MainPages extends StatefulHookConsumerWidget {
  const MainPages({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPagesState();
}

class _MainPagesState extends ConsumerState<MainPages> {
  @override
  Widget build(BuildContext context) {
    final currentIndexPages = ref.watch(bottomBarProvider);

    List<Widget> beforeUploadCV = [
      const HomePages(),
      const Center(
        child: Text('Search'),
      ),
      const Center(
        child: VacanciesPages(),
      ),
      const ProfilePage()
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndexPages,
        children: beforeUploadCV,
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
