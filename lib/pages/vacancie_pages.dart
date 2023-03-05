import 'package:flutter/material.dart';
import 'package:internity/features/vacancies/provider/vacancies_provider.dart';
import 'package:internity/shared/widget/loading_button.dart';

import '../features/profile/provider/profile_provider.dart';
import '../features/vacancies/presentation/vacancie_item_widget.dart';
import '../shared/riverpod_and_hooks.dart';
import '../theme/colors.dart';

class VacanciePages extends HookConsumerWidget {
  const VacanciePages({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(profileProvider);
    final vacancieSelected = ModalRoute.of(context)?.settings.arguments as int?;

    final isApplyLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(primaryTextColor),
        title: const Text(
          'Kembali',
          style: TextStyle(
            color: Color(primaryTextColor),
            fontSize: 12,
          ),
        ),
        titleSpacing: 0,
      ),
      body: userData.when(
          data: (data) {
            return const SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20),
              child: VacancieItemWidget(),
            );
          },
          error: (error, stack) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
      bottomNavigationBar: userData.when(
          data: (userData) => userData.inInternship
              ? null
              : Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(vacancieProvider(vacancieSelected!)).when(
                        data: (vacancieData) => BottomAppBar(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Container(
                                  height: 80,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color(secondaryBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.20),
                                        offset: const Offset(0, -1),
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: LoadingButton(
                                    onPressed: () {
                                      isApplyLoading.value = true;

                                      final toggleVacancie =
                                          vacancieData.inPending
                                              ? ref.read(cancelVacancieProvider(
                                                      vacancieSelected)
                                                  .future)
                                              : ref.read(applyVacancieProvider(
                                                      vacancieSelected)
                                                  .future);

                                      toggleVacancie.then((value) {
                                        ref.refresh(
                                            vacancieProvider(vacancieSelected)
                                                .future);
                                        ref.refresh(profileProvider.future);
                                        isApplyLoading.value = false;
                                      });
                                      toggleVacancie.onError(
                                          (error, stackTrace) =>
                                              isApplyLoading.value = false);
                                    },
                                    text: userData.inPending
                                        ? vacancieData.inPending
                                            ? 'Batal Daftar'
                                            : vacancieData.inProcessed
                                                ? 'Surat Dibuat'
                                                : 'Sudah Mendaftar Ditempat Lain'
                                        : 'Daftar',
                                    isGradient: false,
                                    backgroundColor: userData.inPending
                                        ? vacancieData.inPending
                                            ? const Color(0xFFF03E61)
                                            : const Color(primaryColor)
                                                .withOpacity(0.5)
                                        : const Color(primaryColor),
                                    isLoading: isApplyLoading.value,
                                  )),
                            ),
                        error: (error, stack) =>
                            Center(child: Text(error.toString())),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()));
                  },
                ),
          error: (error, stack) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
