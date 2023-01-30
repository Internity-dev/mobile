import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../../shared/widget/underline_text_field.dart';
import '../../../theme/colors.dart';
import '../provider/auth_provider.dart';

class LoginItemWidget extends StatefulHookConsumerWidget {
  const LoginItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginItemWidgetState();
}

class _LoginItemWidgetState extends ConsumerState<LoginItemWidget> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final _authProvider = ref.watch(authProvider);
    final bool validateError = ref
        .watch(authProvider)
        .maybeWhen(failure: (errorMessage) => true, orElse: () => false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          // Login Banner
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Image(
              width: 250,
              image: AssetImage('assets/images/login_page.png'),
            ),
          ),

          // Login Form
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                // Form Head
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Hi, Selamat Datang',
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
                        // Email Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: emailController,
                            hintText: "Masukan Email",
                            inputType: TextInputType.emailAddress,
                            errorText: validateError
                                ? _authProvider.maybeWhen(
                                    failure: (errorMessage) => errorMessage,
                                    orElse: () => null)
                                : null,
                            validateError: validateError,
                          ),
                        ),

                        // Password Input
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: UnderlineTextField(
                            controller: passwordController,
                            hintText: "Masukan Password",
                            inputType: TextInputType.visiblePassword,
                            errorText: validateError
                                ? _authProvider.maybeWhen(
                                    failure: (errorMessage) => errorMessage,
                                    orElse: () => null)
                                : null,
                            validateError: validateError,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Forgot Password
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(
                        color: Color(primaryTextColor),
                        decoration: TextDecoration.underline,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                // Login Button
                Container(
                  margin: const EdgeInsets.only(top: 5),
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
                    onPressed: () {
                      ref.read(authProvider.notifier).login(
                          email: emailController.text,
                          password: passwordController.text);
                    },
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
                      'Masuk',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(secondaryBackgroundColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Dont have Account
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum punya akun?',
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
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                        child: const Text(
                          'Daftar',
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
