import 'package:flutter/material.dart';
import 'package:fsui/constants.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.dark800,
                      AppColors.light100,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Here\'s what we have lined up for you today:',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Try these!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Here are a few blogs and videos to make you smile!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildBlogCard(
                      imageUrl: 'https://via.placeholder.com/300x200.png?text=Blog+1',
                      title: 'How to Stay Positive',
                      subtitle: 'Tips and tricks for a positive mindset.',
                    ),
                    _buildBlogCard(
                      imageUrl: 'https://via.placeholder.com/300x200.png?text=Blog+2',
                      title: 'The Benefits of Meditation',
                      subtitle: 'Why you should start meditating today.',
                    ),
                    _buildBlogCard(
                      imageUrl: 'https://via.placeholder.com/300x200.png?text=Blog+3',
                      title: 'Healthy Eating Habits',
                      subtitle: 'Simple changes for a healthier diet.',
                    ),
                    _buildBlogCard(
                      imageUrl: 'https://via.placeholder.com/300x200.png?text=Blog+4',
                      title: 'Exercise for Mental Health',
                      subtitle: 'How exercise can improve your mood.',
                    ),
                    _buildBlogCard(
                      imageUrl: 'https://via.placeholder.com/300x200.png?text=Blog+5',
                      title: 'Finding Your Passion',
                      subtitle: 'Discover what makes you happy.',
                    ),
                    _buildBlogCard(
                      imageUrl: 'https://via.placeholder.com/300x200.png?text=Blog+6',
                      title: 'Connecting with Nature',
                      subtitle: 'The importance of outdoor activities.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogCard({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.light100.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
