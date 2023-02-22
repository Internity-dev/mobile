import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../riverpod_and_hooks.dart';

class LoadingButton extends StatefulHookConsumerWidget {
  const LoadingButton(
      {super.key,
      required this.onPressed,
      this.isLoading = false,
      required this.text});

  final void Function() onPressed;
  final bool isLoading;
  final String text;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends ConsumerState<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledForegroundColor: Colors.transparent,
        disabledBackgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 50),
        padding: EdgeInsets.zero,
      ),
      child: widget.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ))
          : Text(
              widget.text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(secondaryBackgroundColor),
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
