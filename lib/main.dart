import 'package:airline_app/view/home/home.dart';
import 'package:airline_app/view/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Airline App',
      home: SplashScreen(
        onContinue: () {
          Get.to(
            () => HomeScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
    );
  }
}
