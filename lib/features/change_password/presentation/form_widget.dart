import 'package:flutter/material.dart';
import 'package:internity/features/change_password/model/error_validation_model.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../shared/widget/outline_label_text_field.dart';

class FormWidget extends StatefulHookConsumerWidget {
  const FormWidget(
      {super.key,
      required this.oldPasswordController,
      required this.newPasswordController,
      required this.confirmPasswordController,
      this.errorValidation,
      required this.formKey});

  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final ErrorValidationModel? errorValidation;
  final GlobalKey<FormState> formKey;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends ConsumerState<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: OutlineLabelTextField(
                controller: widget.oldPasswordController,
                inputType: TextInputType.visiblePassword,
                outlineLabel: 'Password Lama',
                helperText: 'Password lama yang digunakan saat ini',
                helperMaxLines: 2,
                errorText: widget.errorValidation?.errors.oldPassword[0],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: OutlineLabelTextField(
                controller: widget.newPasswordController,
                inputType: TextInputType.visiblePassword,
                outlineLabel: 'Password Baru',
                helperText: 'Panjang password minimal 8 karakter\n'
                    'Mengandung angka\n',
                helperMaxLines: 2,
                errorText: widget.errorValidation?.errors.password[0],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: OutlineLabelTextField(
                controller: widget.confirmPasswordController,
                inputType: TextInputType.visiblePassword,
                outlineLabel: 'Konfirmasi Password',
                helperText: 'Ketikan ulang password',
                helperMaxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
