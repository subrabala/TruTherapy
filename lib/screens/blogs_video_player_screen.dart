import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/user/blogs_controller.dart';
import 'package:fsui/controllers/therapist/therapist_blogs_controller.dart';
import 'package:fsui/controllers/video_player_controller.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BlogsVideoPlayerScreen extends StatefulWidget {
  @override
  _BlogsVideoPlayerScreenState createState() =>
      _BlogsVideoPlayerScreenState();
}

class _BlogsVideoPlayerScreenState extends State<BlogsVideoPlayerScreen> {
  late VideoController controller;

  @override
  void initState() {
    super.initState();
    final scope = getScope();
    final blogController = scope == 'therapist'
        ? (Get.isRegistered<TherapistBlogsController>()
            ? Get.find<TherapistBlogsController>()
            : Get.put(TherapistBlogsController()))
        : (Get.isRegistered<BlogsController>()
            ? Get.find<BlogsController>()
            : Get.put(BlogsController()));

    controller = Get.isRegistered<VideoController>()
        ? Get.find<VideoController>()
        : Get.put(VideoController());

    controller.initializeVideo("$s3_cdn/" + blogController.blogData["video"]);

    // Adding listener once
    controller.videoPlayerController.addListener(_onVideoControllerChange);
  }

  @override
  void dispose() {
    // Remove the listener to avoid memory leaks
    controller.videoPlayerController.removeListener(_onVideoControllerChange);
    super.dispose();
  }

  void _onVideoControllerChange() {
    if (controller.videoPlayerController.value.isInitialized &&
        !controller.isInitialized.value) {
      controller.isInitialized.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final blogController = getScope() == 'therapist'
        ? (Get.isRegistered<TherapistBlogsController>()
            ? Get.find<TherapistBlogsController>()
            : Get.put(TherapistBlogsController()))
        : (Get.isRegistered<BlogsController>()
            ? Get.find<BlogsController>()
            : Get.put(BlogsController()));

    return Scaffold(
      appBar: AppBar(
        title: Text(blogController.blogData["title"] ?? "No Title"),
        titleTextStyle: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isInitialized.value) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (blogController.blogData["created_at"] != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      "Published on: ${convertToReadableDateAndTime(blogController.blogData["created_at"])}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                AspectRatio(
                  aspectRatio: controller.videoPlayerController.value.isInitialized
                      ? controller.videoPlayerController.value.aspectRatio
                      : 16 / 9,
                  child: VideoPlayer(controller.videoPlayerController),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: PastelColors.skyBlue.withOpacity(0.7),
                  elevation: 0,
                  onPressed: () {
                    controller.togglePlayPause();
                  },
                  child: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.lightYellow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Description",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
                        const SizedBox(height: 10),
                        MarkdownBody(
                          data: blogController.blogData["content"] ??
                              "No Content",
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
