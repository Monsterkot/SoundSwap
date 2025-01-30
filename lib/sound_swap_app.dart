import 'package:flutter/material.dart';
import 'package:sound_swap/theme/theme.dart';

import 'views/main_page/main_page.dart';

class SoundSwapApp extends StatelessWidget {
  const SoundSwapApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}