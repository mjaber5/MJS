import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media_project/components/colors/app_color.dart';
import 'package:social_media_project/layout.dart';
import 'package:social_media_project/pages/auth/login_page.dart';
import 'package:social_media_project/provider/user_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SocialApp());
}

final ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: kPrimaryColor,
  background: const Color.fromARGB(255, 255, 255, 255),
  brightness: Brightness.light,
);
final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: kPrimaryColor,
  background: const Color.fromARGB(255, 13, 13, 13),
  brightness: Brightness.dark,
);

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: colorScheme,
          scaffoldBackgroundColor: colorScheme.background,
          textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
            titleSmall: GoogleFonts.ubuntuCondensed(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 61, 61, 61),
            ),
            titleMedium: GoogleFonts.ubuntuCondensed(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 61, 61, 61),
            ),
            titleLarge: GoogleFonts.ubuntuCondensed(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 61, 61, 61),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
            ),
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: darkColorScheme.background,
          textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
            titleSmall: GoogleFonts.ubuntuCondensed(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 144, 144, 144),
            ),
            titleMedium: GoogleFonts.ubuntuCondensed(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 144, 144, 144),
            ),
            titleLarge: GoogleFonts.ubuntuCondensed(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 144, 144, 144),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: darkColorScheme.onPrimary),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done ||
                snapshot.hasData) {
              return const LayoutPage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
