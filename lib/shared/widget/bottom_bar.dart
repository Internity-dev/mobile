import 'package:flutter/material.dart';
import 'package:internity/theme/colors.dart';

import '../provider/bottom_bar_provider.dart';
import '../riverpod_and_hooks.dart';

class BottomBar extends StatefulHookConsumerWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final currentIndexPages = ref.watch(bottomBarProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(primaryBackgroundColor),
      unselectedItemColor: const Color(primaryTextColor),
      selectedItemColor: const Color(primaryColor),
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      currentIndex: currentIndexPages,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Aktivitas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          label: 'Magang',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'Profile',
        ),
      ],
      onTap: (value) => ref.read(bottomBarProvider.notifier).setIndex(value),
    );
  }
}
