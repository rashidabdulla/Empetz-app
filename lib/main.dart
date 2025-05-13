import 'package:empetzapp/homescreen.dart';
import 'package:empetzapp/splashscreen.dart';
import 'package:flutter/material.dart';


final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, darkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const Mysplashscreen(),
        );
      },
    );
  }
}
