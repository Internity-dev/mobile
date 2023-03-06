import 'package:flutter/material.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import '../features/profile/presentation/profile_item.dart';
import '../features/profile/provider/profile_provider.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(profileProvider.future);
        },
        child: SingleChildScrollView(
          child: ProfileItemWidget(),
        ),
      ),
    );
  }
}
