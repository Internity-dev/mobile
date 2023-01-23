import 'package:flutter/material.dart';

import '../../../core/riverpod_and_hooks.dart';

List<Widget> buildOnboardingItems() {
  return [
    Container(
      color: Colors.red,
      child: const Center(
        child: Text('Page 1'),
      ),
    ),
    Container(
      color: Colors.green,
      child: const Center(
        child: Text('Page 2'),
      ),
    ),
    Container(
      color: Colors.blue,
      child: const Center(
        child: Text('Page 3'),
      ),
    ),
  ];
}

final onboardingPageIndex = StateProvider((ref) => 0);
