import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../features/register/presentation/register_item_widget.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: RegisterItemWidget(),
        ),
      ),
    );
  }
}
