import 'package:flutter/material.dart';
import 'package:fsui/controllers/therapist/emergency_chat_controller.dart';
import 'package:fsui/screens/splash_screen.dart';
import 'package:fsui/screens/therapist_screens/chat_logs_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_links/app_links.dart';  
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
        GetPage(
          name: '/chats/:id',
          page: () {
            final sessionId = Get.parameters['id'];
            final EmergencyChatController controller =
                Get.isRegistered<EmergencyChatController>()
                    ? Get.find<EmergencyChatController>()
                    : Get.put(EmergencyChatController());
            controller.getChatsForSession(sessionId!);
            return TherapistChatLogsScreen();
          },
          middlewares: [ChatMiddleware()],
        ),
      ],
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class ChatMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final scope = getScope();
    if (scope != 'therapist') {
      return const RouteSettings(name: '/login');
    }
    return null;
  }

  @override
  Widget Function()? onPageBuildStart(Widget Function()? page) {
    if (getScope() == 'therapist' && isLoggedIn()) {
      return page;
    } else {
      return null;
    }
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _handleInitialUri();
    _initDeepLinkListener();
  }

  void _handleInitialUri() async {
    try {
      final uri = await AppLinks().getInitialLink(); 
      if (uri != null) {
        _navigateToScreen(uri);
      }
    } catch (e) {
      print('Failed to get initial URI: $e');
    }
  }

  void _initDeepLinkListener() {
    _sub = AppLinks().uriLinkStream.listen((Uri? uri) { 
      if (uri != null) {
        _navigateToScreen(uri);
      }
    }, onError: (err) {
      print('Error receiving deep link: $err');
    });
  }

  void _navigateToScreen(Uri uri) {
    switch (uri.host) {
      case 'chats':
        final id = uri.queryParameters['id'];
        if (id != null) {
          Get.toNamed('/chats/$id');
        } else {
          print('Error: Missing id in chats link');
        }
        break;

      case 'profile':
        Get.toNamed('/profile');
        break;

      default:
        print('Unhandled deep link: $uri');
        break;
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
