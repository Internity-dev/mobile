import 'package:flutter/material.dart';
import 'package:internity/features/register/model/post_register_model.dart';
import 'package:internity/features/register/provider/register_provider.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../../shared/widget/loading_button.dart';
import '../../../shared/widget/underline_text_field.dart';
import '../../../theme/colors.dart';
import '../../login/provider/auth_provider.dart';
import '../model/error_validation_model.dart';

class RegisterItemWidget extends StatefulHookConsumerWidget {
  RegisterItemWidget({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterItemWidgetState();
}

class _RegisterItemWidgetState extends ConsumerState<RegisterItemWidget> {
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final courseCodeController = useTextEditingController();

    final isLoading = useState(false);
    final ValueNotifier<ErrorValidationModel?> errorValidation = useState(null);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          // Register Banner
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Image(
              width: 250,
              image: AssetImage('assets/images/register_page.png'),
            ),
          ),

          // Register Form
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                // Form Head
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Ayo Mulai Karirmu!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Form Input
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Form(
                    key: widget.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        // Name Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: nameController,
                            hintText: "Masukan Nama",
                            inputType: TextInputType.name,
                            errorText: errorValidation.value?.errors.name?[0],
                            validateError:
                                errorValidation.value != null ? true : false,
                          ),
                        ),

                        // Email Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: emailController,
                            hintText: "Masukan Email",
                            inputType: TextInputType.emailAddress,
                            errorText: errorValidation.value?.errors.email?[0],
                            validateError:
                                errorValidation.value != null ? true : false,
                          ),
                        ),

                        // Password Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: passwordController,
                            hintText: "Masukan Password",
                            inputType: TextInputType.visiblePassword,
                            errorText:
                                errorValidation.value?.errors.password?[0],
                            validateError: errorValidation.value != null,
                          ),
                        ),

                        // Password Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: confirmPasswordController,
                            hintText: "Masukan Ulang Password",
                            inputType: TextInputType.visiblePassword,
                            validateError: errorValidation.value != null,
                          ),
                        ),

                        // Course Code
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: courseCodeController,
                            hintText: "Kode Kelas",
                            inputType: TextInputType.text,
                            errorText:
                                errorValidation.value?.errors.courseCode?[0],
                            validateError: errorValidation.value != null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Register Button
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: LoadingButton(
                    text: 'Daftar',
                    onPressed: () {
                      PostRegisterModel data = PostRegisterModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        passwordConfirmation: confirmPasswordController.text,
                        courseCode: courseCodeController.text,
                      );

                      isLoading.value = true;

                      final register = ref.read(registerProvider(data).future);

                      register.then((value) async {
                        isLoading.value = false;

                        await ref
                            .refresh(isUserLoginProvider.future)
                            .then((value) => Navigator.pop(context));
                      });

                      register.onError((error, stackTrace) {
                        if (error is ErrorValidationModel) {
                          errorValidation.value = error;
                        }

                        isLoading.value = false;
                      });
                    },
                    isGradient: true,
                    isLoading: isLoading.value,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1090FF),
                        Color(0xFF01C1FF),
                      ],
                    ),
                  ),
                ),

                // Alreadt have Account
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: Color(primaryColor),
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
