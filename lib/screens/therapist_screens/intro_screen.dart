import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/therapist_screens/bottom_navbar_screens/home_screen.dart';
import 'package:fsui/screens/therapist_screens/bottom_navbar_screens/profile_screen.dart';
import 'package:fsui/screens/user_screens/bottom_navbar_screens/aibot_chats_list_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AIBotChatsListScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.light100,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                height: 28,
                'assets/icons/home.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? AppColors.dark800 : AppColors.mid,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                height: 26,
                'assets/icons/chat.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? AppColors.dark800 : AppColors.mid,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                height: 24,
                'assets/icons/profile.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? AppColors.dark800 : AppColors.mid,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.dark800,
          unselectedItemColor: AppColors.mid,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
