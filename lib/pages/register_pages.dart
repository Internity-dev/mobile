import 'package:flutter/material.dart';
import 'package:internity/core/constant.dart';
import 'package:internity/core/riverpod_and_hooks.dart';

import '../features/register/presentation/register_item_widget.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: const Scaffold(
        backgroundColor: Color(primaryBackgroundColor),
        body: SingleChildScrollView(
          child: RegisterItemWidget(),
        ),
      ),
    );
  }
}
