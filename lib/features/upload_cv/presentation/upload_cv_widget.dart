import 'package:flutter/material.dart';
import 'package:internity/shared/widget/loading_button.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../shared/widget/snackbar_error.dart';
import '../../../theme/colors.dart';
import '../provider/upload_cv_provider.dart';

class UploadCV extends HookConsumerWidget {
  const UploadCV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(uploadCVProvider);

    var isUploadLoading = useState(false);

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
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(primaryColor),
            ),
            child: LoadingButton(
              text: "Upload CV",
              onPressed: () {
                isUploadLoading.value = true;
                ref
                    .read(uploadCVProvider)
                    .uploadCVFile()
                    .then((value) => isUploadLoading.value = false)
                    .onError((error, stackTrace) {
                  isUploadLoading.value = false;
                  return SnackbarError.showErrorSnackbar(
                      context, error.toString(), ref);
                });
              },
              isLoading: isUploadLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
