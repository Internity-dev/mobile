import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internity/theme/colors.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../provider/vacancies_provider.dart';

class VacanciesItemWidget extends StatefulHookConsumerWidget {
  const VacanciesItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VacanciesItemWidgetState();
}

class _VacanciesItemWidgetState extends ConsumerState<VacanciesItemWidget> {
  @override
  Widget build(BuildContext context) {
    final vacanciesData = ref.watch(vacanciesProvider);
    final recommendedVacanciesData = ref.watch(recommendedVacanciesProvider);

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: TextField(
              cursorColor: const Color(primaryTextColor),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(primaryTextColor),
                ),
                hintText: "cari tempat magang",
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(primaryTextColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Navigation Item
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.bookmark_outline,
                  //     color: Color(primaryTextColor),
                  //   ),
                  //   label: const Text(
                  //     "Tersimpan",
                  //     style: TextStyle(
                  //       decoration: TextDecoration.underline,
                  //       color: Color(primaryTextColor),
                  //     ),
                  //   ),
                  // ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/vacancies-status');
                    },
                    icon: const Icon(
                      Icons.pending_actions_outlined,
                      color: Color(primaryTextColor),
                    ),
                    label: const Text(
                      "Status Pendaftaran",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(primaryTextColor),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/my-intern');
                    },
                    icon: const Icon(
                      Icons.work_outline_rounded,
                      color: Color(primaryTextColor),
                    ),
                    label: const Text(
                      "MagangKu",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(primaryTextColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Recommended Vacancies Item
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rekomendasi Untukmu',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                recommendedVacanciesData.when(
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
                                    imageUrl: item.company.logo,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
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
                                          item.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(item.company.name,
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        Text(
                                          item.company.city,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(secondaryTextColor)),
                                        ),
                                        Text(
                                          '${item.applied} Pendaftar',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(primaryColor)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // const Icon(Icons.bookmark_outline),
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
                              // color: Colors.red,
                              margin: const EdgeInsets.only(top: 50),
                              child:
                                  const Center(child: Text('Tidak ada data'))),
                        ],
                      );
                    }
                  },
                  error: (error, stack) => Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Center(child: Text(error.toString()))),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // Vacancies Item
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Magang Terbaru',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                vacanciesData.when(
                  data: (data) => Column(
                    children: data.map((item) {
                      return Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                                width: 50,
                                fit: BoxFit.cover,
                                imageUrl: item.company.logo,
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
                                      item.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(item.company.name,
                                        style: const TextStyle(fontSize: 12)),
                                    Text(
                                      item.company.city,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(secondaryTextColor)),
                                    ),
                                    Text(
                                      '${item.applied} Pendaftar',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(primaryColor)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const Icon(Icons.bookmark_outline),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  error: (error, stack) => Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Center(child: Text(error.toString()))),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
