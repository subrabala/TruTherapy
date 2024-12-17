import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/aibot_screen.dart';
import 'package:fsui/widgets/blog_card.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  text: 'Hello, \n',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Alice',
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFC0FEFC).withOpacity(0.4),
                      AppColors.light100,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "How would you describe your mood?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Happy box
                        _MoodBox(
                          emoji: ":)",
                          label: "Happy",
                          color:
                              Color.fromARGB(255, 255, 249, 197).withOpacity(1),
                        ),
                        // Sad box
                        _MoodBox(
                          emoji: ":(",
                          label: "Sad",
                          color: Colors.blueAccent.withOpacity(0.3),
                        ),
                        // Angry box
                        _MoodBox(
                          emoji: ":/",
                          label: "Angry",
                          color: Colors.redAccent.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ],
                ),
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
                'Yoga videos to make you smile from inside!',
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
    return GestureDetector(
      onTap: () {
        Get.to(() => AIBotScreen(chatId:label));
      },
      child: Container(
          width: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 26, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.alphaBlend(
                            color.withOpacity(0.8),
                            color,
                          ).computeLuminance() >
                          0.5
                      ? Color.fromARGB(255, 231, 215, 68).withOpacity(1)
                      : Color.alphaBlend(color.withOpacity(0.8), color),
                ),
              )
            ],
          )),
    );
  }
}
