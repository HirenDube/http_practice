import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http_practice/HomeScreen.dart';

FlutterLocalNotificationsPlugin flanp = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  runApp(const MyApp());

  AndroidInitializationSettings initialiseAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings initialiseIOS =
      DarwinInitializationSettings(defaultPresentAlert: true);
  InitializationSettings initializationSettings =
      InitializationSettings(android: initialiseAndroid, iOS: initialiseIOS);
  bool? didInitialised = await flanp.initialize(initializationSettings);
  // log("didInitialised : $didInitialised");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder()
        }),
        appBarTheme: AppBarTheme(backgroundColor: CupertinoColors.systemYellow),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
