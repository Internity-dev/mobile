import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../features/presences/model/post_presences_model.dart';
import '../features/presences/provider/presences_provider.dart';
import '../shared/riverpod_and_hooks.dart';
import '../theme/colors.dart';

class PresencesPages extends HookConsumerWidget {
  const PresencesPages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clock = useState(DateFormat.Hms('id_ID').format(DateTime.now()));
    final date =
        useState(DateFormat.yMMMMEEEEd('id_ID').format(DateTime.now()));

    final presencesType = ModalRoute.of(context)?.settings.arguments as String?;

    // timer
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        clock.value = DateFormat.Hms('id_ID').format(DateTime.now());
        date.value = DateFormat.yMMMMEEEEd('id_ID').format(DateTime.now());
      });
      return timer.cancel;
    }, const []);

    return SafeArea(
      child: Scaffold(
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(clock.value,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(date.value,
                          style: const TextStyle(fontSize: 18)),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1090FF),
                            Color(0xFF01C1FF),
                          ],
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (presencesType == 'in') {
                            PostPresencesModel data = PostPresencesModel(
                              checkIn: clock.value,
                              presenceStatusId: 1,
                            );

                            ref.read(presencesPostProvider(data));
                          } else if (presencesType == 'out') {
                            PostPresencesModel data = PostPresencesModel(
                              checkOut: clock.value,
                              presenceStatusId: 2,
                            );

                            ref.read(presencesPostProvider(data));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 200),
                          shape: const CircleBorder(),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          presencesType == 'in' ? 'Masuk' : 'Keluar',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
