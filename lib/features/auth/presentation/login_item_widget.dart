import 'package:flutter/material.dart';
import 'package:internity/core/riverpod_and_hooks.dart';

class LoginItemWidget extends StatefulHookConsumerWidget {
  const LoginItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginItemWidgetState();
}

class _LoginItemWidgetState extends ConsumerState<LoginItemWidget> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isObscure = useState(true);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
            child: Column(children: [
              // Form Head
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Hi, Selamat Datang',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Form Input
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Input
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                        ),
                      ),

                      // Password Input
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: isObscure.value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () => isObscure.value = !isObscure.value,
                              child: Icon(
                                isObscure.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
