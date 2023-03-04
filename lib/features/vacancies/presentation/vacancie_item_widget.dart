import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internity/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../provider/vacancies_provider.dart';

class VacancieItemWidget extends StatefulHookConsumerWidget {
  const VacancieItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VacancieItemWidgetState();
}

class _VacancieItemWidgetState extends ConsumerState<VacancieItemWidget> {
  @override
  Widget build(BuildContext context) {
    final vacancieSelected = ModalRoute.of(context)?.settings.arguments as int?;

    final vacancieData = ref.watch(vacancieProvider(vacancieSelected!));

    return Container(
      padding: const EdgeInsets.all(10),
      child: vacancieData.when(
          data: (data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          width: 50,
                          fit: BoxFit.cover,
                          imageUrl: data.company.logo,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => SizedBox(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                              height: 50,
                              child: Center(child: Icon(Icons.error))),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(primaryTextColor),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.company.name,
                                  style: const TextStyle(
                                    color: Color(primaryTextColor),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '${data.company.city}, ${data.company.country}',
                                  style: const TextStyle(
                                    color: Color(primaryTextColor),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Vacancies Status Section
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${data.applied} Pendaftar',
                            style: const TextStyle(
                                color: Color(primaryColor), fontSize: 12)),
                        Text(
                          'Dibuat ${DateFormat.yMMMMd('id_ID').format(DateTime.parse(data.createdAt))}',
                          style: const TextStyle(
                              color: Color(primaryTextColor), fontSize: 10),
                        ),
                        Text(
                          'Terakhir diupdate ${DateFormat.yMMMMd('id_ID').format(DateTime.parse(data.updatedAt))}',
                          style: const TextStyle(
                              color: Color(primaryTextColor), fontSize: 10),
                        )
                      ],
                    ),
                  ),

                  // Skill Required Section
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Skill Dibutuhkan',
                          style: TextStyle(
                            color: Color(primaryTextColor),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: double.infinity,
                            child: Wrap(
                              spacing: 10,
                              children: data.getSkills
                                      ?.map(
                                        (skill) => Chip(
                                          label: Text(
                                            skill,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ))
                      ],
                    ),
                  ),

                  // Description  Section
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deskripsi Pekerjaan',
                          style: TextStyle(
                            color: Color(primaryTextColor),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: HtmlWidget(data.description),
                        )
                      ],
                    ),
                  ),

                  // Company Description  Section
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tentang Perusahaan',
                          style: TextStyle(
                            color: Color(primaryTextColor),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Company Profile
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                width: 50,
                                fit: BoxFit.cover,
                                imageUrl: data.company.logo,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
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
                                            Center(child: Icon(Icons.error))),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.company.name,
                                        style: const TextStyle(
                                          color: Color(primaryTextColor),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.apartment_outlined,
                                            color: Color(primaryTextColor),
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                data.company.category,
                                                style: const TextStyle(
                                                  color:
                                                      Color(primaryTextColor),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Color(primaryTextColor),
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                '${data.company.city}, ${data.company.country}',
                                                style: const TextStyle(
                                                  color:
                                                      Color(primaryTextColor),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.language_outlined,
                                            color: Color(primaryTextColor),
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                data.company.website,
                                                style: const TextStyle(
                                                  color:
                                                      Color(primaryTextColor),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // Company Address Section
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Alamat',
                                style: TextStyle(
                                  color: Color(primaryTextColor),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  data.company.address,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Company Contact Section
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Kontak',
                                style: TextStyle(
                                  color: Color(primaryTextColor),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.person_outline_outlined,
                                            color: Color(primaryTextColor),
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                data.company.phone,
                                                style: const TextStyle(
                                                  color:
                                                      Color(primaryTextColor),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.email_outlined,
                                            color: Color(primaryTextColor),
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                data.company.email,
                                                style: const TextStyle(
                                                  color:
                                                      Color(primaryTextColor),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.call_outlined,
                                            color: Color(primaryTextColor),
                                            size: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                data.company.contactPerson,
                                                style: const TextStyle(
                                                  color:
                                                      Color(primaryTextColor),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
          error: (error, stack) => Container(
              margin: const EdgeInsets.only(top: 50),
              child: Center(child: Text(error.toString()))),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
