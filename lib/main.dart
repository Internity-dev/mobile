import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internity/features/login/provider/auth_provider.dart';
import 'package:internity/pages/edit_intern_page.dart';
import 'package:internity/pages/edit_profile_pages.dart';
import 'package:internity/pages/vacancie_pages.dart';
import 'package:internity/pages/vacancies_status_pages.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'pages/change_password_pages.dart';
import 'pages/create_journal.dart';
import 'pages/login_pages.dart';
import 'pages/my_intern_pages.dart';
import 'pages/news_page.dart';
import 'pages/notification_pages.dart';
import 'pages/onboarding_pages.dart';
import 'pages/presences_pages.dart';
import 'pages/register_pages.dart';
import 'theme/colors.dart';
import 'pages/main_pages.dart';

late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://d275a05777f0454baf3e145c366b184b@o4504376921096192.ingest.sentry.io/4504558263992320';
  //     options.tracesSampleRate = 1.0;
  //     options.diagnosticLevel = SentryLevel.error;
  //   },
  //   appRunner: () =>
  //       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //           .then((_) {
  //     runApp(const ProviderScope(child: MyApp()));
  //   }),
  // );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: const Color(primaryBackgroundColor),
      ),
      home: SafeArea(
          child: ref.watch(isUserLoginProvider).when(
              skipLoadingOnReload: true,
              data: (data) {
                if (data == UserStatus.onboarding) {
                  return const OnboardingPage();
                } else if (data == UserStatus.loggedIn) {
                  return const MainPages();
                } else {
                  return LoginPage();
                }
              },
              error: (error, stackTrace) {
                return LoginPage();
              },
              loading: () {
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.stretchedDots(
                            color: const Color(primaryColor), size: 80),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            'Memuat Halaman',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
      routes: {
        '/login': (context) => LoginPage(),
        '/onboard': (context) => const OnboardingPage(),
        '/register': (context) => const RegisterPage(),
        '/main': (context) => const MainPages(),
        '/vacancies-status': (context) => const VacanciesStatusPages(),
        '/my-intern': (context) => const MyInternPages(),
        '/vacancie-detail': (context) => const VacanciePages(),
        '/change-password': (context) => ChangePasswordPages(),
        '/presences': (context) => const PresencesPages(),
        '/edit-profile': (context) => EditProfilePages(),
        'create-journal': (context) => CreateJournal(),
        '/notification': (context) => const NotificationPages(),
        '/news': (context) => const NewsPage(),
        '/edit-intern-date': (context) => EditInternDate(),
      },
    );
  }
}
