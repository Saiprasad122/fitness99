import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'global/router/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.routes,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 0.95),
        child: child!,
      ),
      title: '99Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppPages.INITIAL,
    );
  }
}
