import 'package:flutter/material.dart';
import 'package:internity/core/constant.dart';
import 'package:internity/core/riverpod_and_hooks.dart';

import '../features/auth/presentation/login_item_widget.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: const Scaffold(
        backgroundColor: Color(primaryBackgroundColor),
        body: SingleChildScrollView(
          child: LoginItemWidget(),
        ),
      ),
    );
  }
}
