import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/blogs_controller.dart';
import 'package:fsui/controllers/user_details_controller.dart';
import 'package:fsui/screens/aibot_screen.dart';
import 'package:fsui/widgets/blog_card.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final BlogsController controller = Get.isRegistered<BlogsController>()
      ? Get.find<BlogsController>()
      : Get.put(BlogsController());


  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllBlogs();
    });
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/fsui_minimal.png',
                    height: 30,
                  ),
                  SizedBox(width: 10),
                  const Text(
                    'Welcome back , ',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                    colors: [
                      PastelColors.seaBlue,
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
                    // MOOD BOX
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
                          color: const Color.fromARGB(255, 244, 141, 141)
                              .withOpacity(0.4),
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
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Yoga videos to make you smile from inside!',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: controller.blogs.isEmpty
                    ? const Center(
                        child: Text('No blogs available'),
                      )
                    : ListView(
                        children: controller.blogs.map<Widget>((blog) {
                          return BlogCard(
                            imageUrl: blog.thumbnail,
                            title: blog.title,
                            subtitle: blog.description,
                            url: blog.blogId,
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
        Get.to(() => AIBotScreen());
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
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.alphaBlend(
                            color,
                            color,
                          ).computeLuminance() >
                          0.5
                      ? Color.fromARGB(255, 210, 192, 33).withOpacity(1)
                      : Color.alphaBlend(color.withOpacity(0.8), color),
                ),
              )
            ],
          )),
    );
  }
}
