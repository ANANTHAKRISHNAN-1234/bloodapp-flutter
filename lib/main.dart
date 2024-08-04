// ignore_for_file: prefer_const_constructors, unused_import
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/add.dart';
import 'package:sample_project/home.dart';
import 'package:sample_project/update.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     /* theme: ThemeData(
        primaryColor: Colors.red,
      ),*/
      routes:{ 
        '/':(context) => Homepage(),
        '/add':(context) => AddUser(),
        '/update':(context)=>UpdateDonor(),
      },
      initialRoute: '/',
      );
  }
}