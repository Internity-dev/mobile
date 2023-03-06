import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../riverpod_and_hooks.dart';

class OutlineLabelTextField extends StatefulHookConsumerWidget {
  const OutlineLabelTextField(
      {super.key,
      this.helperText,
      required this.outlineLabel,
      this.helperMaxLines,
      required this.controller,
      this.errorText});

  final String? helperText;
  final int? helperMaxLines;
  final String outlineLabel;
  final TextEditingController controller;
  final String? errorText;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OutlineLabelTextFieldState();
}

class _OutlineLabelTextFieldState extends ConsumerState<OutlineLabelTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.outlineLabel,
          style: const TextStyle(
            color: Color(primaryTextColor),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            controller: widget.controller,
            style: const TextStyle(
              color: Color(primaryTextColor),
              fontSize: 14,
            ),
            cursorColor: const Color(primaryTextColor),
            decoration: InputDecoration(
              helperText: widget.helperText,
              helperMaxLines: widget.helperMaxLines,
              errorText: widget.errorText,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFF22272E).withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFF22272E).withOpacity(0.5)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE53E3E)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
