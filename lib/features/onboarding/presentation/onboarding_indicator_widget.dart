import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';
import '../provider/onboarding_provider.dart';

class OnboardingIndicatorWidget extends StatefulHookConsumerWidget {
  final PageController controller;

  const OnboardingIndicatorWidget({super.key, required this.controller});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingIndicatorWidgetState();
}

class _OnboardingIndicatorWidgetState
    extends ConsumerState<OnboardingIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    final onboardingPageIndex = ref.watch(onboardingPageIndexProvider);
    final onboardingPageCount = ref.watch(onboardingPageCountProvider);

    final isLastPage = onboardingPageIndex == onboardingPageCount - 1;

    return Container(
      alignment: const Alignment(0, 0.95),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Skip Button
          Visibility(
            visible: !isLastPage,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: TextButton(
              onPressed: () {
                widget.controller.animateToPage(
                  onboardingPageCount - 1,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text(
                'Lewati',
                style: TextStyle(
                  color: Color(primaryTextColor),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Page Indicator
          SmoothPageIndicator(
            controller: widget.controller, // PageControllers
            count: onboardingPageCount,
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(primaryTextColor),
              dotColor: Color(0xFFD9D9D9),
              dotHeight: 10,
              dotWidth: 15,
            ), // your preferred effect
            onDotClicked: (index) {
              widget.controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),

          // Next Button
          TextButton(
            onPressed: () {
              widget.controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: isLastPage
                ? const SizedBox()
                : const Text(
                    'Lanjut',
                    style: TextStyle(
                      color: Color(primaryTextColor),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
