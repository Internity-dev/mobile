import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';
import '../provider/vacancies_provider.dart';

class VacanciesItemStatusWidget extends HookConsumerWidget {
  const VacanciesItemStatusWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internRegistStatusData = ref.watch(internRegistStatusProvider);

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recommended Vacancies Item
          Container(
            child: internRegistStatusData.when(
              data: (data) {
                if (data.isNotEmpty) {
                  return Column(
                    children: data.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                                width: 50,
                                fit: BoxFit.cover,
                                imageUrl: item.vacancy.company.logo,
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(
                                        height: 50,
                                        child:
                                            Center(child: Icon(Icons.error)))),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.vacancy.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(item.vacancy.company.name,
                                        style: const TextStyle(fontSize: 12)),
                                    Text(
                                      item.vacancy.company.city,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(secondaryTextColor)),
                                    ),
                                    Text(
                                      '${item.vacancy.applied} Pendaftar',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(primaryColor)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ChipStatus(
                              label: item.status,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(child: Text('Tidak ada data'))),
                    ],
                  );
                }
              },
              error: (error, stack) => Center(child: Text(error.toString())),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}

class ChipStatus extends HookConsumerWidget {
  const ChipStatus({
    super.key,
    required this.label,
  });

  final String label;

  int statusColor() {
    if (label == 'accepted') {
      return 0xFF0FB782;
    } else if (label == 'rejected') {
      return 0xFFF03E61;
    } else {
      return 0xFFE9B207;
    }
  }

  int statusBackgroundColor() {
    if (label == 'accepted') {
      return 0xFFA3F0D0;
    } else if (label == 'rejected') {
      return 0xFFF9CAD1;
    } else {
      return 0xFFF5ED8D;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Chip(
      label: Text(
        label == 'accepted'
            ? 'Diterima'
            : label == 'rejected'
                ? 'Ditolak'
                : 'Diproses',
        style: TextStyle(fontSize: 10, color: Color(statusColor())),
      ),
      backgroundColor: Color(statusBackgroundColor()),
      padding: EdgeInsets.zero,
    );
  }
}
