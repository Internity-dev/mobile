import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../theme/colors.dart';

class UnderlineTextField extends StatefulHookConsumerWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final String? errorText;
  final bool? validateError;

  const UnderlineTextField(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.hintText,
      this.errorText,
      this.validateError});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UnderlineTextFieldState();
}

class _UnderlineTextFieldState extends ConsumerState<UnderlineTextField> {
  @override
  Widget build(BuildContext context) {
    final isObscure =
        useState(widget.inputType == TextInputType.visiblePassword);

    final isValidateError = useState(widget.validateError ?? false);

    return TextFormField(
      style: const TextStyle(
        color: Color(primaryTextColor),
        fontSize: 14,
      ),
      onTap: () => isValidateError.value = false,
      cursorColor: const Color(primaryTextColor),
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: isObscure.value,
      decoration: InputDecoration(
        hintText: widget.hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(primaryTextColor),
          ),
        ),
        errorText: isValidateError.value ? widget.errorText : null,
        suffixIcon: widget.inputType == TextInputType.visiblePassword
            ? GestureDetector(
                onTap: () => isObscure.value = !isObscure.value,
                child: Icon(
                  isObscure.value ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
