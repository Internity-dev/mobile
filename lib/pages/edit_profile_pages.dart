import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internity/features/profile/model/post_profile_model.dart';
import 'package:internity/features/profile/provider/profile_provider.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';
import 'package:intl/intl.dart';

import '../shared/widget/custom_app_bar.dart';
import '../shared/widget/loading_button.dart';
import '../shared/widget/outline_label_text_field.dart';
import '../theme/colors.dart';

class EditProfilePages extends StatefulHookConsumerWidget {
  EditProfilePages({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfilePagesState();
}

class _EditProfilePagesState extends ConsumerState<EditProfilePages> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(profileProvider);

    final emailController = useTextEditingController(
      text: userData.requireValue.email,
    );
    final nameController = useTextEditingController(
      text: userData.requireValue.name,
    );
    final phoneController = useTextEditingController(
      text: userData.requireValue.phone ?? '',
    );
    final addressController = useTextEditingController(
      text: userData.requireValue.address ?? '',
    );
    final aboutController = useTextEditingController(
      text: userData.requireValue.bio ?? '',
    );
    final skillController = useTextEditingController(
      text: userData.requireValue.skills ?? '',
    );
    final genderController = useState<String?>(
      userData.requireValue.gender,
    );

    final image = useState<XFile?>(null);
    final datePicked = useState<DateTime?>(
      userData.requireValue.dateOfBirth != null
          ? DateTime.parse(userData.requireValue.dateOfBirth!)
          : null,
    );

    final isLoading = useState(false);

    return Scaffold(
      appBar: const CustomBackButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: userData.when(
                data: (data) {
                  return Column(
                    children: [
                      // Change Profile Picture
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            InkWell(
                                onTap: () async {
                                  await ref
                                      .read(
                                          getLocalProfilePictureProvider.future)
                                      .then((value) => image.value = value);
                                },
                                child: Stack(
                                  children: [
                                    image.value == null
                                        ? data.avatarUrl != null
                                            ? CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: data.avatarUrl!,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage(data
                                                              .gender ==
                                                          'male'
                                                      ? 'assets/images/man.png'
                                                      : data.gender == 'female'
                                                          ? 'assets/images/woman.png'
                                                          : 'assets/images/question.png'),
                                                ),
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  return CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage:
                                                        imageProvider,
                                                  );
                                                },
                                              )
                                            : CircleAvatar(
                                                backgroundImage: AssetImage(data
                                                            .gender ==
                                                        'male'
                                                    ? 'assets/images/man.png'
                                                    : data.gender == 'female'
                                                        ? 'assets/images/woman.png'
                                                        : 'assets/images/question.png'),
                                                radius: 50,
                                              )
                                        : CircleAvatar(
                                            backgroundImage: FileImage(
                                                image.value?.path != null
                                                    ? File(image.value!.path)
                                                    : File('')),
                                            radius: 50,
                                          ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 20,
                                          color:
                                              Color.fromARGB(255, 15, 28, 46),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),

                      // Form
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Form(
                          key: widget.formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: OutlineLabelTextField(
                                  controller: emailController,
                                  inputType: TextInputType.emailAddress,
                                  outlineLabel: 'Email',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: OutlineLabelTextField(
                                  controller: nameController,
                                  inputType: TextInputType.name,
                                  outlineLabel: 'Nama',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: OutlineLabelTextField(
                                  controller: addressController,
                                  inputType: TextInputType.streetAddress,
                                  outlineLabel: 'Alamat',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: OutlineLabelTextField(
                                  controller: phoneController,
                                  inputType: TextInputType.phone,
                                  outlineLabel: 'Nomor Telepon',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jenis Kelamin',
                                      style: TextStyle(
                                        color: Color(primaryTextColor),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    DropdownButtonFormField(
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'male',
                                          child: Text('Laki-laki'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'female',
                                          child: Text('Perempuan'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        if (value is String) {
                                          genderController.value = value;
                                        }
                                      },
                                      value: genderController.value,
                                      style: const TextStyle(
                                        color: Color(primaryTextColor),
                                        fontSize: 12,
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
                                      'Tanggal Lahir',
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
                                            initialDate: datePicked.value ??
                                                DateTime.now(),
                                            firstDate: DateTime(1800),
                                            lastDate: DateTime.now(),
                                            helpText: 'Pilih Tanggal Lahir',
                                            cancelText: 'Batal',
                                            confirmText: 'Pilih',
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      const ColorScheme.light(
                                                    primary:
                                                        Color(primaryColor),
                                                    onPrimary:
                                                        Color(0xFFE4E6EB),
                                                    onSurface:
                                                        Color(primaryColor),
                                                  ),
                                                  dialogBackgroundColor:
                                                      const Color(0xFFE4E6EB),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          const Color(
                                                              0xFFE4E6EB),
                                                      backgroundColor:
                                                          const Color(
                                                              primaryColor),
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          ).then((value) {
                                            if (value != null) {
                                              datePicked.value = value;
                                            }

                                            return datePicked.value;
                                          });
                                        },
                                        icon: const Icon(Icons.date_range),
                                        label: Text(datePicked.value == null
                                            ? 'Pilih Tanggal Lahir'
                                            : '${datePicked.value?.day}/'
                                                '${datePicked.value?.month}/'
                                                '${datePicked.value?.year}'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(primaryColor),
                                          foregroundColor:
                                              const Color(0xFFE4E6EB),
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: OutlineLabelTextField(
                                  controller: aboutController,
                                  inputType: TextInputType.text,
                                  outlineLabel: 'Tentang Saya',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: OutlineLabelTextField(
                                  controller: skillController,
                                  inputType: TextInputType.text,
                                  outlineLabel: 'Skills',
                                  helperText:
                                      'Pisahkan Dengan koma ex: vuejs,flutter',
                                ),
                              ),
                              LoadingButton(
                                text: 'Kirim',
                                onPressed: () {
                                  isLoading.value = true;

                                  PostUserModel data = PostUserModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                    bio: aboutController.text,
                                    skills: skillController.text,
                                    dateOfBirth: datePicked.value != null
                                        ? DateFormat('yyyy-MM-dd')
                                            .format(datePicked.value!)
                                        : null,
                                    gender: genderController.value,
                                  );

                                  if (image.value != null) {
                                    ref.read(uploadProfilePictureProvider(
                                        MultipartFile.fromFileSync(
                                            image.value!.path)));
                                  }

                                  final result = ref
                                      .read(editProfileProvider(data).future);

                                  result.then((value) {
                                    ref.refresh(profileProvider);
                                    isLoading.value = false;
                                  });

                                  result.onError((error, stackTrace) {
                                    isLoading.value = false;
                                  });
                                },
                                isGradient: true,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1090FF),
                                    Color(0xFF01C1FF),
                                  ],
                                ),
                                isLoading: isLoading.value,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                error: (error, stack) => Center(child: Text(error.toString())),
                loading: () =>
                    const Center(child: CircularProgressIndicator()))),
      ),
    );
  }
}
