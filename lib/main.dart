import 'package:flutter/material.dart';
import 'package:fsui/screens/splash_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await SharedPrefs().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: SplashScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
