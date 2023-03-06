import 'package:flutter/material.dart';
import 'package:internity/pages/home_pages.dart';
import 'package:internity/pages/reports_pages.dart';

import '../features/profile/provider/profile_provider.dart';
import '../shared/provider/bottom_bar_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../shared/widget/bottom_bar.dart';
import 'activity_pages.dart';
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
    final userData = ref.watch(profileProvider);

    List<Widget> beforeIntern = [
      const HomePages(),
      // const ActivityPages(),
      const VacanciesPages(),
      const ProfilePage()
    ];

    List<Widget> onIntern = [
      const HomePages(),
      // const ActivityPages(),
      const ReportsPages(),
      const VacanciesPages(),
      const ProfilePage()
    ];

    return Scaffold(
      body: userData.when(
          data: (data) {
            return IndexedStack(
              index: currentIndexPages,
              children: data.inInternship ? onIntern : beforeIntern,
            );
          },
          error: (error, stack) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
