import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../theme/colors.dart';

class CustomBackButton extends HookConsumerWidget
    implements PreferredSizeWidget {
  final List<Widget>? actions;

  const CustomBackButton({
    super.key,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: const Color(primaryTextColor),
      title: const Text(
        'Kembali',
        style: TextStyle(
          color: Color(primaryTextColor),
          fontSize: 12,
        ),
      ),
      actions: actions,
      titleSpacing: 0,
    );
  }
}
