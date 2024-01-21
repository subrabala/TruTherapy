import 'package:flutter/material.dart';
import 'package:fsui/screens/auth_screen.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double greenSectionHeight = screenHeight * 0.6;
    double textSectionHeight = screenHeight * 0.4;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: greenSectionHeight,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 190, 221, 215),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Page 1
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Lottie.network(
                    'https://lottie.host/264d05ad-e788-4b70-aa39-b2a038fd0737/PqFZaU5km3.json',
                  ),
                ),
                // Page 2
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Lottie.network(
                    'https://lottie.host/13f60176-ee78-4adf-a786-21fddf19bb21/LkGoga4Eqv.json',
                  ),
                ),
                Lottie.network(
                  'https://lottie.host/1e8bac7a-0070-4007-b3c7-c6163dd5b3a2/gPEg7RqHdI.json',
                ),
              ],
            ),
          ),
          Container(
            height: textSectionHeight,
            padding: const EdgeInsets.all(40.0),
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Texts for Page 1
                if (_currentPage == 0)
                  const Column(
                    children: [
                      Text(
                        'Embrace Our Warm Welcome!',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "It's okay to feel here. You're not alone. Let's navigate anxiety and depression together.",
                        style: TextStyle(fontSize: 12.0, height: 1.2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                // Texts for Page 2
                if (_currentPage == 1)
                  const Column(
                    children: [
                      Text(
                        ' Begin Your Healing Journey!',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Engage, share, and heal. Private, one-to-one talks await at the end of each conversation.",
                        style: TextStyle(fontSize: 12.0, height: 1.2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                // Texts for Page 3
                if (_currentPage == 2)
                  const Column(
                    children: [
                      Text(
                        'Your Privacy Matters',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Share details for personalized support and guidance on your healing journey.",
                        style: TextStyle(fontSize: 12.0, height: 1.2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                // Row for navigation buttons

                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: _currentPage > 0
                          ? () {
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          : null,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: _currentPage != 2
                          ? () {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          : () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthScreen()));
                            },
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
