import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/user/aibot_controller.dart';
import 'package:fsui/controllers/user/blogs_controller.dart';
import 'package:fsui/screens/aibot_screen.dart';
import 'package:fsui/utils.dart';
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
      checkJwtAndRedirectIfExpired();
      controller.fetchAllBlogs();
    });

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
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
                    'Welcome back ! ',
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
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "How would you describe your mood?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 14),
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
                          firstQuery:
                              "Hey! I'm feeling happy today! Can you suggest me something to do?",
                        ),
                        // Sad box
                        _MoodBox(
                          emoji: ":(",
                          label: "Sad",
                          color: Colors.blueAccent.withOpacity(0.3),
                          firstQuery:
                              "Hello, I'm feeling quite sad today :( What can I do to feel better?",
                        ),
                        // Angry box
                        _MoodBox(
                          emoji: ":/",
                          label: "Angry",
                          color: const Color.fromARGB(255, 244, 141, 141)
                              .withOpacity(0.4),
                          firstQuery:
                              "I'm feeling very angry today!!! Can you give some tips on how to manage anger?",
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
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchAllBlogs();
                    },
                    child: controller.blogs.isEmpty
                        ? ListView( 
                            children: const [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 100),
                                  child: Text('No blogs available'),
                                ),
                              ),
                            ],
                          )
                        : ListView(
                            children: controller.blogs.map<Widget>((blog) {
                              return BlogCard(
                                id: blog.blogId,
                                imageUrl: blog.thumbnail,
                                title: blog.title,
                                subtitle: blog.description,
                                url: blog.title,
                              );
                            }).toList(),
                          ),
                  ),
                ),
              )
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
  final String firstQuery;

  const _MoodBox({
    Key? key,
    required this.emoji,
    required this.label,
    required this.color,
    required this.firstQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<AIBotController>().currentSessionId = null;
        Get.find<AIBotController>().chatHistory.clear();
        Get.to(() => AIBotScreen(
              firstQuery: firstQuery,
            ));
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
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
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
