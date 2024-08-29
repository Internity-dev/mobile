import 'package:flutter/material.dart';
import 'package:internity/features/change_password/model/error_validation_model.dart';

import '../features/change_password/model/change_password_model.dart';
import '../features/change_password/presentation/form_widget.dart';
import '../features/change_password/provider/change_repository_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../shared/widget/custom_app_bar.dart';
import '../theme/colors.dart';

class ChangePasswordPages extends StatefulHookConsumerWidget {
  ChangePasswordPages({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordPagesState();
}

class _ChangePasswordPagesState extends ConsumerState<ChangePasswordPages> {
  @override
  Widget build(BuildContext context) {
    final oldPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final isLoading = useState(false);
    final ValueNotifier<ErrorValidationModel?> errorValidation = useState(null);

    return Stack(children: [
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: CustomBackButton(
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      ChangePasswordModel data = ChangePasswordModel(
                        oldPassword: oldPasswordController.text,
                        password: newPasswordController.text,
                        passwordConfirmation: confirmPasswordController.text,
                      );

                      isLoading.value = true;

                      final changePassword =
                          ref.read(changePasswordProvider(data).future);

                      changePassword.then((value) {
                        isLoading.value = false;
                        Navigator.pop(context);
                      });

                      changePassword.onError((error, stackTrace) {
                        if (error is ErrorValidationModel) {
                          errorValidation.value = error;
                        }

                        isLoading.value = false;
                      });
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        color: Color(primaryTextColor),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: FormWidget(
              formKey: widget.formKey,
              oldPasswordController: oldPasswordController,
              newPasswordController: newPasswordController,
              confirmPasswordController: confirmPasswordController,
              errorValidation: errorValidation.value,
            ),
          ),
        ),
      ),

      // Loading
      isLoading.value
          ? Container(
              color: Colors.black.withOpacity(0.8),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
