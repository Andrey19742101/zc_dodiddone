import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DoDidDoneTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
