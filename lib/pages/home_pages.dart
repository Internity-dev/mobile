import 'package:flutter/material.dart';
import 'package:internity/features/upload_cv/presentation/upload_cv_widget.dart';
import 'package:internity/theme/colors.dart';

import '../shared/riverpod_and_hooks.dart';

class HomePages extends StatefulHookConsumerWidget {
  const HomePages({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePagesState();
}

class _HomePagesState extends ConsumerState<HomePages> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                          children: const [
                            Text(
                              'Hai, Jamil',
                              style: TextStyle(
                                color: Color(secondaryBackgroundColor),
                                fontSize: 20,
                              ),
                            ),
                            Text(
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
                    Container(
                      height: 201,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) => Container(
                          height: 400,
                          width: 250,
                          margin: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(secondaryBackgroundColor),
                                ),
                                height: 140,
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/images/news.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Peluncuran Internity untuk memantau siswa magang dalam hal absensi dan laporan harian',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '22 Februari 2023',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(secondaryTextColor),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Upload CV
              const UploadCV(),
            ],
          ),
        ),
      ),
    );
  }
}
