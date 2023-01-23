import 'package:flutter/material.dart';

import '../../../core/riverpod_and_hooks.dart';
import '../provider/onboarding_provider.dart';

class OnboardingItemWidget extends StatefulHookConsumerWidget {
  final PageController controller;

  const OnboardingItemWidget({super.key, required this.controller});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingItemWidgetState();
}

class _OnboardingItemWidgetState extends ConsumerState<OnboardingItemWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.controller,
      onPageChanged: (value) =>
          ref.read(onboardingPageIndex.notifier).state = value,
      children: buildOnboardingItems(),
    );
  }
}
