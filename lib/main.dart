import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/main_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        cardTheme: CardTheme(
          elevation: 0,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      home: const MainPage(),
    );
  }
}
