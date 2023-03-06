import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internity/shared/widget/loading_button.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';
import '../../login/provider/auth_provider.dart';
import '../provider/profile_provider.dart';

class ProfileItemWidget extends HookConsumerWidget {
  const ProfileItemWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Picture
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(primaryColor),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: profileData.when(
            data: (data) => Column(
              children: [
                data.avatarUrl != null
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: data.avatarUrl!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => SizedBox(
                          height: 10,
                          width: 10,
                          child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(data.gender == 'male'
                              ? 'assets/images/man.png'
                              : data.gender == 'female'
                                  ? 'assets/images/woman.png'
                                  : 'assets/images/question.png'),
                        ),
                        imageBuilder: (context, imageProvider) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: imageProvider,
                          );
                        },
                      )
                    : CircleAvatar(
                        backgroundImage: AssetImage(data.gender == 'male'
                            ? 'assets/images/man.png'
                            : data.gender == 'female'
                                ? 'assets/images/woman.png'
                                : 'assets/images/question.png'),
                        radius: 50,
                      ),

                const SizedBox(height: 10),

                Text(
                  textAlign: TextAlign.center,
                  data.name,
                  style: const TextStyle(
                    color: Color(secondaryBackgroundColor),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  textAlign: TextAlign.center,
                  data.email,
                  style: const TextStyle(
                    color: Color(secondaryBackgroundColor),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 20),

                // Edit Profile and Edit CV
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Color(secondaryBackgroundColor),
                          size: 20,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Edit Profile',
                          style: TextStyle(
                            color: Color(secondaryBackgroundColor),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.edit_document,
                          color: Color(secondaryBackgroundColor),
                          size: 20,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Edit CV',
                          style: TextStyle(
                            color: Color(secondaryBackgroundColor),
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            error: (error, stack) => Center(child: Text(error.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),

        // Profile Detail
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Info Saya',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  profileData.when(
                    data: (data) => Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                data.gender == 'male'
                                    ? Icons.male
                                    : data.gender == 'female'
                                        ? Icons.female
                                        : Icons.male_outlined,
                                color: const Color(primaryTextColor),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(data.gender == 'male'
                                    ? 'Laki-Laki'
                                    : data.gender == 'female'
                                        ? 'Perempuan'
                                        : 'Tidak Diketahui'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Color(primaryTextColor),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(data.address ?? 'Tidak Diketahui'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.call_outlined,
                                color: Color(primaryTextColor),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: Text(data.phone ?? 'Tidak Diketahui')),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.cake_outlined,
                                color: Color(primaryTextColor),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: Text(
                                      data.dateOfBirth ?? 'Tidak Diketahui')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    error: (error, stack) =>
                        Center(child: Text(error.toString())),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // About Me
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tentang Saya',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  profileData.when(
                    data: (data) => Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Text(data.bio ?? 'Tidak Diketahui'),
                    ),
                    error: (error, stack) =>
                        Center(child: Text(error.toString())),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Skills
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Skills',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    width: double.infinity,
                    child: profileData.when(
                        data: (data) {
                          return data.getSkills != null &&
                                  data.getSkills!.isNotEmpty
                              ? Wrap(
                                  spacing: 10,
                                  children: data.getSkills
                                          ?.map((skill) =>
                                              Chip(label: Text(skill)))
                                          .toList() ??
                                      [],
                                )
                              : const Center(child: Text('Tidak Diketahui'));
                        },
                        error: (error, stack) =>
                            Center(child: Text(error.toString())),
                        loading: () =>
                            const Center(child: CircularProgressIndicator())),
                  )
                ],
              ),

              const SizedBox(height: 25),

              // Action Button
              Column(
                children: [
                  // Change Password Navigation
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/change-password');
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.lock_outline,
                          color: Color(primaryTextColor),
                          size: 25,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Ganti Password',
                            style: TextStyle(
                              color: Color(primaryTextColor),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(primaryTextColor),
                          size: 25,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Logout Button
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer(builder: (context, ref, child) {
                            final authData = ref.watch(authProvider);

                            return Container(
                              padding: const EdgeInsets.all(20),
                              alignment: Alignment.centerLeft,
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Akun kamu bakal keluar dari aplikasi',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(primaryTextColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 15),
                                          child: LoadingButton(
                                            onPressed: () {
                                              ref
                                                  .read(authProvider.notifier)
                                                  .logout()
                                                  .then((value) =>
                                                      Navigator.pop(context));
                                            },
                                            text: 'Keluar',
                                            isGradient: false,
                                            backgroundColor:
                                                const Color(0xFFF03E61),
                                            isLoading: authData.maybeWhen(
                                              loading: () => true,
                                              orElse: () => false,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.lock_outline,
                          color: Color(0xFFF03E61),
                          size: 25,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Keluar',
                            style: TextStyle(
                              color: Color(0xFFF03E61),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFF03E61),
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
