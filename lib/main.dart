import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:styling_and_arch/pages/home_page.dart';
import 'package:styling_and_arch/theme/theme_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ? CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses planner',
      theme: iosLightTheme,
      home: const HomePage(), 

    )

    : MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses planner',
      theme: lightTheme,
      home: const HomePage(),
    );
  }
}
