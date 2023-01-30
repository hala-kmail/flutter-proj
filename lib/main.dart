// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, unused_field

import 'package:SWMC/firstPage.dart';
import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'googlemap.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

bool islogin = false;

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(null, [
    // notification icon
    NotificationChannel(
      channelGroupKey: 'basic_test',
      channelKey: 'basic',
      channelName: 'Basic notifications',
      channelDescription: 'Notification  for SMWC',
      channelShowBadge: true,
      defaultColor: Color.fromARGB(255, 127, 205, 247),
      ledColor: Color.fromARGB(255, 0, 16, 40),
      playSound: true,
      importance: NotificationImportance.High,
      enableVibration: true,
      onlyAlertOnce: true
    ),
  ]);
  var usr = FirebaseAuth.instance.currentUser;
  if (usr == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbapp = Firebase.initializeApp();
  // This widget is the root of your application.
  late DatabaseReference _counterRef;
  late final FirebaseApp app;
  Map<String, String> m = {};
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Google Maps With Markers',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: 
       firstPage(),
        );
  }
}
