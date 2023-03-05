import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../riverpod_and_hooks.dart';

class LoadingButton extends StatefulHookConsumerWidget {
  const LoadingButton(
      {super.key,
      required this.onPressed,
      this.isLoading = false,
      required this.text,
      required this.isGradient,
      this.backgroundColor,
      this.gradient});

  final void Function() onPressed;
  final bool isLoading;
  final String text;
  final bool isGradient;

  final Color? backgroundColor;
  final Gradient? gradient;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends ConsumerState<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isGradient
        ? Container(
            margin: const EdgeInsets.only(top: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: widget.gradient,
            ),
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
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
            ),
          )
        : ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.backgroundColor ?? const Color(primaryBackgroundColor),
              disabledBackgroundColor:
                  widget.backgroundColor ?? const Color(primaryBackgroundColor),
              minimumSize: const Size(double.infinity, 50),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
