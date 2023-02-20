import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internity/features/login/provider/auth_provider.dart';
import 'package:internity/shared/riverpod_and_hooks.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/login_pages.dart';
import 'pages/onboarding_pages.dart';
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

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
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
    final isOnboarding = useState(prefs.getBool('is_onboarding') ?? true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: const Color(primaryBackgroundColor),
      ),
      home: SafeArea(
          child: isOnboarding.value
              ? const OnboardingPage()
              : FutureBuilder(
                  future: ref.watch(isUserLoginProvider.future),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        return const MainPages();
                      } else {
                        return const LoginPage();
                      }
                    } else {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  })),
      routes: {
        '/login': (context) => const LoginPage(),
        '/onboard': (context) => const OnboardingPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
