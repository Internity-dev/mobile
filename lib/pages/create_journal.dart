import 'package:flutter/material.dart';
import '../features/change_password/model/error_validation_model.dart';
import '../features/journal/model/post_journal_model.dart';
import '../features/profile/provider/profile_provider.dart';
import '../shared/widget/loading_button.dart';

import '../features/daily_activity/provider/daily_activity_provider.dart';
import '../features/journal/provider/journal_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../shared/widget/custom_app_bar.dart';
import '../shared/widget/outline_label_text_field.dart';
import '../theme/colors.dart';

class CreateJournal extends StatefulHookConsumerWidget {
  CreateJournal({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateJournalState();
}

class _CreateJournalState extends ConsumerState<CreateJournal> {
  @override
  Widget build(BuildContext context) {
    final workTypeController = useTextEditingController();
    final descriptionController = useTextEditingController();

    final isLoading = useState(false);
    final ValueNotifier<ErrorValidationModel?> errorValidation = useState(null);

    final userData = ref.watch(profileProvider);

    return Scaffold(
      appBar: const CustomBackButton(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: OutlineLabelTextField(
                    controller: workTypeController,
                    inputType: TextInputType.text,
                    outlineLabel: 'Jenis Pekerjaan',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: OutlineLabelTextField(
                    controller: descriptionController,
                    inputType: TextInputType.text,
                    outlineLabel: 'Deskripsi Pekerjaan',
                  ),
                ),
                LoadingButton(
                  onPressed: () {
                    isLoading.value = true;

                    userData.maybeWhen(
                        data: (data) {
                          final activityData = ref.read(
                              dailyActivityProvider(data.activeCompany!)
                                  .future);

                          activityData.then((value) {
                            PostJournal data = PostJournal(
                              description: descriptionController.text,
                              workType: workTypeController.text,
                              activityId: value.journal?.id,
                            );

                            ref.read(postJournalProvider(data).future).then(
                                (value) => {
                                      isLoading.value = false,
                                      Navigator.pop(context)
                                    });
                          });
                        },
                        orElse: () {});
                  },
                  text: 'Kirim',
                  isGradient: false,
                  backgroundColor: Color(primaryColor),
                  isLoading: isLoading.value,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
