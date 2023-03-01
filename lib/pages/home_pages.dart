import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internity/features/upload_cv/presentation/upload_cv_widget.dart';
import 'package:internity/theme/colors.dart';

import '../features/login/provider/auth_provider.dart';
import '../features/news/presentation/news_slider_widget.dart';
import '../features/profile/provider/profile_provider.dart';
import '../features/vacancies/provider/vacancies_provider.dart';
import '../shared/riverpod_and_hooks.dart';

class HomePages extends StatefulHookConsumerWidget {
  const HomePages({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePagesState();
}

class _HomePagesState extends ConsumerState<HomePages> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(profileProvider);
    final recommendedVacanciesData = ref.watch(recommendedVacanciesProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(primaryColor),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // Introduction
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Greeting
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hai, ${userData.value?.name ?? ' '}',
                              style: const TextStyle(
                                color: Color(secondaryBackgroundColor),
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              'mau magang dimana?',
                              style: TextStyle(
                                color: Color(secondaryBackgroundColor),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Notification
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF706E6E).withOpacity(0.42),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.notifications,
                              color: Color(secondaryBackgroundColor),
                            ),
                          ),
                        )
                      ],
                    ),

                    // Search Bar
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextField(
                        style: const TextStyle(
                          color: Color(primaryTextColor),
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari tempat magang',
                          hintStyle: const TextStyle(
                            color: Color(primaryTextColor),
                            fontSize: 12,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(primaryTextColor),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 40,
                          ),
                          filled: true,
                          fillColor: const Color(secondaryBackgroundColor),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // News Slider
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Berita Terbaru',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Lihat Semua',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(secondaryTextColor),
                            ),
                          ),
                        )
                      ],
                    ),

                    // News Item
                    const NewsSliderWidget(),
                  ],
                ),
              ),

              // Upload CV
              userData.when(
                  data: (data) {
                    if (data.resumeUrl == null) {
                      return const UploadCV();
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Rekomendasi Untukmu',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
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
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        SizedBox(
                                                          height: 50,
                                                          child: Center(
                                                            child: CircularProgressIndicator(
                                                                value: downloadProgress
                                                                    .progress),
                                                          ),
                                                        ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    const SizedBox(
                                                        height: 50,
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.error)))),
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(item.company.name,
                                                        style: const TextStyle(
                                                            fontSize: 12)),
                                                    Text(
                                                      item.company.city,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              secondaryTextColor)),
                                                    ),
                                                    Text(
                                                      '${item.applied} Pendaftar',
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              primaryColor)),
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
                                          margin:
                                              const EdgeInsets.only(top: 50),
                                          child: const Center(
                                              child: Text('Tidak ada data'))),
                                    ],
                                  );
                                }
                              },
                              error: (error, stack) => Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  child: Center(child: Text(error.toString()))),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  error: (error, stack) =>
                      Center(child: Text(error.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
      ),
    );
  }
}
