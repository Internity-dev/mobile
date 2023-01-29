import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sentry_flutter/sentry_flutter.dart';

import 'pages/login_pages.dart';
import 'pages/onboarding_pages.dart';
import 'pages/register_pages.dart';
import 'theme/colors.dart';
import 'pages/main_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://d275a05777f0454baf3e145c366b184b@o4504376921096192.ingest.sentry.io/4504558263992320';
      options.tracesSampleRate = 1.0;
      DiagnosticLevel.error;
    },
    appRunner: () =>
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
            .then((_) {
      runApp(const ProviderScope(child: MyApp()));
    }),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: const Color(primaryBackgroundColor),
      ),
      home: const SafeArea(
        child: MainPages(),
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/onboard': (context) => const OnboardingPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
