import 'package:flutter/material.dart';
import 'package:internity/pages/home_pages.dart';

import '../shared/provider/bottom_bar_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../shared/widget/bottom_bar.dart';

class MainPages extends StatefulHookConsumerWidget {
  const MainPages({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPagesState();
}

class _MainPagesState extends ConsumerState<MainPages> {
  @override
  Widget build(BuildContext context) {
    final currentIndexPages = ref.watch(bottomBarProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndexPages,
        children: const [
          Center(
            child: HomePages(),
          ),
          Center(
            child: Text('Search'),
          ),
          Center(
            child: Text('Add'),
          ),
          Center(
            child: Text('Favorite'),
          ),
          Center(
            child: Text('Profile'),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
