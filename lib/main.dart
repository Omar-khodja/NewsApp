import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screen/home_screen.dart';

final kColorscheme = ColorScheme.fromSeed(
  seedColor: Colors.tealAccent,
  brightness: Brightness.dark,
);
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData.from(
            colorScheme: kColorscheme,
            textTheme: GoogleFonts.robotoTextTheme().copyWith(
              titleLarge: TextStyle(
                fontSize: 24,
                color: kColorscheme.onSurface,
              ),
              titleMedium: TextStyle(color: kColorscheme.onSurface),
              titleSmall: TextStyle(color: kColorscheme.onSurface,),
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
