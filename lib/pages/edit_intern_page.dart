import 'package:flutter/material.dart';

import '../features/vacancies/model/change_intern_date_model.dart';
import '../features/vacancies/provider/vacancies_provider.dart';
import '../features/vacancies/repository/vacancies_repository.dart';
import '../shared/riverpod_and_hooks.dart';
import '../shared/widget/custom_app_bar.dart';
import '../theme/colors.dart';

class EditInternDate extends StatefulHookConsumerWidget {
  EditInternDate({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditInternDateState();
}

class _EditInternDateState extends ConsumerState<EditInternDate> {
  @override
  Widget build(BuildContext context) {
    final internDateStart = useState<DateTime?>(null);
    final internDateEnd = useState<DateTime?>(null);

    final vacancieSelected = ModalRoute.of(context)?.settings.arguments as int?;

    final isLoading = useState(false);
    // final ValueNotifier<ErrorValidationModel?> errorValidation = useState(null);

    return Stack(children: [
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: CustomBackButton(
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () async {
                      ChangeInternDate data = ChangeInternDate(
                          startDate:
                              '${internDateStart.value!.year}-${internDateStart.value!.month}-${internDateStart.value!.day}',
                          endDate:
                              '${internDateEnd.value!.year}-${internDateEnd.value!.month}-${internDateEnd.value!.day}');

                      ref
                          .watch(vacanciesRepositoryProvider)
                          .changeInternDate(vacancieSelected!, data)
                          .then((value) async {
                        await ref.refresh(myInternProvider.future);

                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        color: Color(primaryTextColor),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal Mulai',
                          style: TextStyle(
                            color: Color(primaryTextColor),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await showDatePicker(
                                context: context,
                                initialDate:
                                    internDateStart.value ?? DateTime.now(),
                                firstDate: DateTime(1800),
                                lastDate: DateTime(3000),
                                helpText: 'Pilih Tanggal Mulai',
                                cancelText: 'Batal',
                                confirmText: 'Pilih',
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(primaryColor),
                                        onPrimary: Color(0xFFE4E6EB),
                                        onSurface: Color(primaryColor),
                                      ),
                                      dialogBackgroundColor:
                                          const Color(0xFFE4E6EB),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              const Color(0xFFE4E6EB),
                                          backgroundColor:
                                              const Color(primaryColor),
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
                                  internDateStart.value = value;
                                }

                                return internDateStart.value;
                              });
                            },
                            icon: const Icon(Icons.date_range),
                            label: Text(internDateStart.value == null
                                ? 'Pilih Tanggal Mulai'
                                : '${internDateStart.value?.day}/'
                                    '${internDateStart.value?.month}/'
                                    '${internDateStart.value?.year}'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(primaryColor),
                              foregroundColor: const Color(0xFFE4E6EB),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tanggal Selesai',
                          style: TextStyle(
                            color: Color(primaryTextColor),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await showDatePicker(
                                context: context,
                                initialDate:
                                    internDateEnd.value ?? DateTime.now(),
                                firstDate: DateTime(1800),
                                lastDate: DateTime(3000),
                                helpText: 'Pilih Tanggal Selesai',
                                cancelText: 'Batal',
                                confirmText: 'Pilih',
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(primaryColor),
                                        onPrimary: Color(0xFFE4E6EB),
                                        onSurface: Color(primaryColor),
                                      ),
                                      dialogBackgroundColor:
                                          const Color(0xFFE4E6EB),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              const Color(0xFFE4E6EB),
                                          backgroundColor:
                                              const Color(primaryColor),
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
                                  internDateEnd.value = value;
                                }

                                return internDateEnd.value;
                              });
                            },
                            icon: const Icon(Icons.date_range),
                            label: Text(internDateEnd.value == null
                                ? 'Pilih Tanggal Selesai'
                                : '${internDateEnd.value?.day}/'
                                    '${internDateEnd.value?.month}/'
                                    '${internDateEnd.value?.year}'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(primaryColor),
                              foregroundColor: const Color(0xFFE4E6EB),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Loading
      isLoading.value
          ? Container(
              color: Colors.black.withOpacity(0.8),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox(),
    ]);
  }
}
