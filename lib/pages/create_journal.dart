import 'package:flutter/material.dart';
import 'package:internity/features/change_password/model/error_validation_model.dart';
import 'package:internity/features/journal/model/post_journal_model.dart';

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
                    onTap: () {
                      PostJournal data = PostJournal(
                        description: descriptionController.text,
                        workType: workTypeController.text,
                      );

                      isLoading.value = true;

                      final result = ref.read(postJournalProvider(data).future);

                      result.then((value) => isLoading.value = false);
                      result.onError((error, stackTrace) {
                        if (error is ErrorValidationModel) {
                          errorValidation.value = error;
                        }

                        isLoading.value = false;
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
                ],
              ),
            ),
          )),
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
