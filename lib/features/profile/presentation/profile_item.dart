import 'package:flutter/material.dart';
import 'package:internity/shared/widget/loading_button.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';
import '../../login/provider/auth_provider.dart';

class ProfileItemWidget extends HookConsumerWidget {
  const ProfileItemWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                'Muhamad Jamil Fanreza',
                style: TextStyle(
                  color: Color(secondaryBackgroundColor),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                textAlign: TextAlign.center,
                'rezaramdhani461@gmail.com',
                style: TextStyle(
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
        ),

        // Profile Detail
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              // Personal Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Info Saya',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.male,
                              color: Color(primaryTextColor),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(child: Text('Laki-Laki')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(
                              Icons.location_on_outlined,
                              color: Color(primaryTextColor),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                  'Jalan Karadenan, kampung parakan kembang RT 03 RW 13'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(
                              Icons.call_outlined,
                              color: Color(primaryTextColor),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(child: Text('085156526837')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Icon(
                              Icons.cake_outlined,
                              color: Color(primaryTextColor),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(child: Text('Laki-Laki')),
                          ],
                        ),
                      ],
                    ),
                  )
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
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: const Text(
                        'Junior Frontend Developer, love to code and learn more about software engineering and software architecture, happy to contribute to open source also sometimes trading in cryptocurrency'),
                  )
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
                    child: Wrap(
                      spacing: 10,
                      children: const [
                        Chip(label: Text('Vue.Js')),
                        Chip(label: Text('Javascripts')),
                        Chip(label: Text('HTML')),
                        Chip(label: Text('CSS')),
                        Chip(label: Text('SCSS')),
                        Chip(label: Text('Flutter')),
                        Chip(label: Text('Dart')),
                        Chip(label: Text('Bootstrap')),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 25),

              // Action Button
              Column(
                children: [
                  // Change Password Navigation
                  Row(
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
                                            backgroundColor: 0xFFF03E61,
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
