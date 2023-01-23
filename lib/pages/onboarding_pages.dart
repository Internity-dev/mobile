import 'package:flutter/material.dart';
import 'package:internity/features/onboarding/presentation/onboarding_indicator_widget.dart';

import '../core/riverpod_and_hooks.dart';
import '../features/onboarding/presentation/onboarding_item_widget.dart';

class OnboardingPage extends HookConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingPageController = usePageController();

    return Scaffold(
      body: Stack(
        children: [
          OnboardingItemWidget(
            controller: onboardingPageController,
          ),
          OnboardingIndicatorWidget(
            controller: onboardingPageController,
          ),
        ],
      ),
    );
  }
}
