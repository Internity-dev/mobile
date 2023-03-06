import 'package:flutter/material.dart';
import 'package:internity/theme/colors.dart';

import '../shared/riverpod_and_hooks.dart';

class ActivityPages extends StatefulHookConsumerWidget {
  const ActivityPages({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActivityPagesState();
}

class _ActivityPagesState extends ConsumerState<ActivityPages> {
  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);
    final _pageController = usePageController();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectedIndex.value = 0;
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _selectedIndex.value == 0
                            ? const Color(primaryColor)
                            : const Color(0xFFD0E9FF),
                        foregroundColor: _selectedIndex.value == 0
                            ? Colors.white
                            : const Color(primaryColor),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Text(
                        'Absensi',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  // Button 2
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectedIndex.value = 1;
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _selectedIndex.value == 1
                            ? const Color(primaryColor)
                            : const Color(0xFFD0E9FF),
                        foregroundColor: _selectedIndex.value == 1
                            ? Colors.white
                            : const Color(primaryColor),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Text(
                        'Laporan',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  // Button 3
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _selectedIndex.value = 2;
                        _pageController.animateToPage(2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _selectedIndex.value == 2
                            ? const Color(primaryColor)
                            : const Color(0xFFD0E9FF),
                        foregroundColor: _selectedIndex.value == 2
                            ? Colors.white
                            : const Color(primaryColor),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Text(
                        'Registrasi',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    key: const PageStorageKey('page1'),
                    child: Container(
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    key: const PageStorageKey('page2'),
                    child: Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Page 2'),
                            leading: const Icon(Icons.home_outlined),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    key: const PageStorageKey('page3'),
                    child: Container(
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
