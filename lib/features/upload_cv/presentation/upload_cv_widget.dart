import 'package:flutter/material.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';
import '../provider/upload_cv_provider.dart';

class UploadCV extends HookConsumerWidget {
  const UploadCV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(uploadCVProvider);

    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text(
            "Upload CV mu yuk!",
            style: TextStyle(
              color: Color(primaryTextColor),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text.rich(
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(primaryTextColor),
                fontSize: 12,
              ),
              TextSpan(
                text:
                    "Biar kami bisa kasih rekomendasi tempat magang sesuai dengan skill yang kamu punya,",
                children: [
                  TextSpan(
                    text: " pastiin CV nya ATS ya :)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                ref.read(uploadCVProvider).getLocalFile();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Upload CV"),
            ),
          ),
        ],
      ),
    );
  }
}
