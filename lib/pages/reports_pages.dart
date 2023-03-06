import 'package:flutter/material.dart';
import 'package:internity/features/journal/provider/journal_provider.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';
import 'package:internity/theme/colors.dart';

import '../features/journal/model/journal_model.dart';
import '../features/profile/provider/profile_provider.dart';
import '../features/register/presentation/register_item_widget.dart';

class ReportsPages extends HookConsumerWidget {
  const ReportsPages({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(profileProvider);
    final reportData =
        ref.watch(journalProvider(userData.value?.activeCompany ?? 0));

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jurnal'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(primaryTextColor),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create-journal');
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(
                journalProvider(userData.value?.activeCompany ?? 0).future);
          },
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: reportData.when(
                    data: (data) {
                      return Column(
                          children: data.map((result) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.workType,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                result.description,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(result.date,
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
