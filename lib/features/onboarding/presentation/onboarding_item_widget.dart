import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1480FF),
            Color(0xFF00C2FF),
          ],
        ),
      ),
      child: PageView(
          controller: widget.controller,
          onPageChanged: (value) =>
              ref.read(onboardingPageIndexProvider.notifier).state = value,
          children: [
            const _OnboardingItem(
              title: 'Buat dan pantau laporan',
              textBody:
                  'Buat laporan langsung dalam aplikasi, tanpa takut lupa',
              image: 'assets/images/onboard_page1.png',
            ),
            const _OnboardingItem(
              title: 'Absensi mudah dimana saja',
              textBody: 'Absensi dengan mudah melalui aplikasi',
              image: 'assets/images/onboard_page2.png',
            ),
            _OnboardingItem(
                title: 'Informasi tempat magang',
                textBody:
                    'Dapatkan informasi tempat magang yang tersedia dan daftar dengan mudah',
                image: 'assets/images/onboard_page3.png',
                widgetFooter: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: (() =>
                        Navigator.pushReplacementNamed(context, '/login')),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(primaryTextColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Ayo Mulai!',
                      style: GoogleFonts.poppins(
                        color: const Color(primaryBackgroundColor),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          ]),
    );
  }
}

class _OnboardingItem extends HookConsumerWidget {
  final String title;
  final String textBody;
  final String image;
  final Widget? widgetFooter;

  const _OnboardingItem(
      {required this.title,
      required this.textBody,
      required this.image,
      this.widgetFooter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 40),
      child: Column(
        children: [
          // PageImage
          Container(
            child: Image(
              width: 250,
              image: AssetImage(image),
            ),
          ),

          // PageBody
          Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: const Color(primaryTextColor),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      textBody,
                      style: const TextStyle(
                        color: Color(primaryTextColor),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),

          // PageFooter
          widgetFooter != null ? widgetFooter! : const SizedBox(),
        ],
      ),
    );
  }
}
