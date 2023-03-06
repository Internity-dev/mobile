import 'package:flutter/material.dart';
import 'package:internity/features/journal/provider/journal_provider.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';
import 'package:internity/shared/widget/custom_app_bar.dart';
import 'package:internity/theme/colors.dart';
import 'package:intl/intl.dart';

import '../features/notification/provider/notification_provider.dart';
import '../features/profile/provider/profile_provider.dart';

class NotificationPages extends HookConsumerWidget {
  const NotificationPages({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationData = ref.watch(notificationProvider);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: const CustomBackButton(),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(notificationProvider.future);
          },
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: notificationData.when(
                    data: (data) {
                      return Column(
                          children: data.map((result) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.title,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                result.body,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                  DateFormat.yMMMMd('id_ID')
                                      .format(DateTime.parse(result.createdAt)),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(secondaryTextColor))),
                            ],
                          ),
                        );
                      }).toList());
                    },
                    error: (error, stack) => Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Center(child: Text(error.toString()))),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()))),
          ),
        ),
      ),
    );
  }
}
