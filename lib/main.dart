import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screen/home_screen.dart';

final kColorscheme = ColorScheme.fromSeed(
  seedColor: Colors.tealAccent,
  brightness: Brightness.dark,
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
            ThemeData.from(
              colorScheme: kColorscheme,
              textTheme: GoogleFonts.robotoTextTheme().copyWith(
              titleLarge:  TextStyle(
                  fontSize: 24,
                  color: kColorscheme.onSurface ,
              ),
              titleMedium: TextStyle(
                color: kColorscheme.onSurface,
              ),
              titleSmall: TextStyle(
                color: kColorscheme.onSurface,
              ),
            ),
          ).copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: kColorscheme.primaryContainer,
            ),
            scaffoldBackgroundColor: kColorscheme.surface,
          ),
      home: const HomeScreen(),
    );
  }
}
