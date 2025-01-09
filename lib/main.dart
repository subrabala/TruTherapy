import 'package:flutter/material.dart';
import 'package:fsui/screens/splash_screen.dart';
import 'package:fsui/screens/therapist_screens/bottom_navbar_screens/emergency_chats.dart';
import 'package:fsui/screens/user_screens/bottom_navbar_screens/aibot_chats_list_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/chats', page: () => AIBotChatsListScreen()),
        GetPage(name: '/emergencychats', page: () => EmergencyChats()),
      ],
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleInitialUri();
    _initDeepLinkListener();
  }

  void _handleInitialUri() async {
    try {
      final uri = await getInitialUri();
      if (uri != null) {
        _navigateToScreen(uri);
      }
    } catch (e) {
      print('Failed to get initial URI: $e');
    }
  }

  void _initDeepLinkListener() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _navigateToScreen(uri);
      }
    }, onError: (err) {
      print('Error receiving deep link: $err');
    });
  }

  void _navigateToScreen(Uri uri) {
    print("Deeplink $uri");

    switch (uri.host) {
      case 'chats':
        Get.toNamed('/chats');
        break;

      case 'emergencychats':
        Get.toNamed('/emergencychats');
        break;

      case 'profile':
        Get.toNamed('/profile');
        break;

      case 'emergencychat':
        String? id = uri.queryParameters['id'];
        if (id != null) {
          Get.toNamed('/emergencychat', parameters: {'id': id});
        } else {
          print('Error: Missing id in emergencychat link');
        }
        break;

      default:
        print('Unhandled deep link: $uri');
        break;
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
