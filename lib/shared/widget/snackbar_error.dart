import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../theme/colors.dart';

class SnackbarError {
  static showErrorSnackbar(
      BuildContext context, String message, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          color: Color(secondaryBackgroundColor),
          fontWeight: FontWeight.bold,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ));
  }
}

// class SnackbarError extends HookConsumerWidget {
//   const SnackbarError({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SnackBar(
//       content: const Text(
//         'Gagal mengunggah CV',
//         style: TextStyle(
//           fontSize: 14,
//           color: Color(secondaryBackgroundColor),
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       backgroundColor: Colors.red,
//     );
//   }
// }
