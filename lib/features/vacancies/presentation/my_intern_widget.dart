import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';
import '../provider/vacancies_provider.dart';

class MyInternWidget extends HookConsumerWidget {
  const MyInternWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myInternData = ref.watch(myInternProvider);

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recommended Vacancies Item
          Container(
            child: myInternData.when(
              data: (data) {
                if (data.isNotEmpty) {
                  return Column(
                    children: data.map((item) {
                      return GestureDetector(
                        onTap: () => item.internDate.endDate == null &&
                                item.internDate.startDate == null
                            ? Navigator.pushNamed(context, '/edit-intern-date',
                                arguments: item.vacancy.companyId)
                            : null,
                        child: Container(
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
                                          child: Center(
                                              child: Icon(Icons.error)))),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        'Tanggal Mulai ${item.internDate.startDate ?? 'Belum Diisi'}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(primaryColor)),
                                      ),
                                      Text(
                                        'Tanggal Selesai ${item.internDate.endDate ?? 'Belum Diisi'}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(primaryColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
