import 'package:flutter/material.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';

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
            ],
          ),
        )
      ],
    );
  }
}
