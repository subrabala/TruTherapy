import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/widgets/blog_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(174, 23, 167, 199).withOpacity(0.4),
                      AppColors.light100,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back, Alice',
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
                "How would you describe your mood?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Happy box
            _MoodBox(
              emoji : ":)",
              label: "Happy",
              color: Colors.greenAccent.withOpacity(0.3), 
            ),
            // Sad box
            _MoodBox(
              emoji : ":(",
              label: "Sad",
              color: Colors.blueAccent.withOpacity(0.3), 
            ),
            // Angry box
            _MoodBox(
              emoji : ":/",
              label: "Angry",
              color: Colors.redAccent.withOpacity(0.3), 
            ),
          ],
        ),
              const SizedBox(height: 20),
              const Text(
                'Try these!',
                textAlign: TextAlign.left,
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
                  children: jsonData.map<Widget>((blog) {
                    return BlogCard(
                      imageUrl: blog['imageUrl'] ?? "",
                      title: blog['title'] ?? "",
                      subtitle: blog['subtitle'] ?? "",
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _MoodBox extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;

  const _MoodBox({
    Key? key,
    required this.emoji,
    required this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, 
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: TextStyle(fontSize: 24),),
          const SizedBox(height: 5), 
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
