import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../../shared/widget/underline_text_field.dart';
import '../../../theme/colors.dart';

class RegisterItemWidget extends StatefulHookConsumerWidget {
  const RegisterItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterItemWidgetState();
}

class _RegisterItemWidgetState extends ConsumerState<RegisterItemWidget> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

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
                    key: formKey,
                    child: Column(
                      children: [
                        // Name Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: nameController,
                            hintText: "Masukan Nama",
                            inputType: TextInputType.name,
                          ),
                        ),

                        // Email Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: emailController,
                            hintText: "Masukan Email",
                            inputType: TextInputType.emailAddress,
                          ),
                        ),

                        // Password Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: passwordController,
                            hintText: "Masukan Password",
                            inputType: TextInputType.visiblePassword,
                          ),
                        ),

                        // Password Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: confirmPasswordController,
                            hintText: "Masukan Ulang Password",
                            inputType: TextInputType.visiblePassword,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Register Button
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1090FF),
                        Color(0xFF01C1FF),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(secondaryBackgroundColor),
                        fontWeight: FontWeight.bold,
                      ),
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
