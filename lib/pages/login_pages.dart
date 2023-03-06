import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../features/login/presentation/login_item_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: LoginItemWidget(
            formKey: widget.formKey,
          ),
        ),
      ),
    );
  }
}
