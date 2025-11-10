import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/widgets/delta_text_view.dart';
import 'package:fsui/controllers/user/blogs_controller.dart';
import 'package:fsui/controllers/therapist/therapist_blogs_controller.dart';
import 'package:fsui/controllers/video_player_controller.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';

class BlogsVideoPlayerScreen extends StatefulWidget {
  @override
  _BlogsVideoPlayerScreenState createState() => _BlogsVideoPlayerScreenState();
}

class _BlogsVideoPlayerScreenState extends State<BlogsVideoPlayerScreen> {
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
      body:
          // Obx(() {
          // if (controller.isInitialized.value) {
          // return SingleChildScrollView(
          // child:
          Column(
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
          if (blogController.blogData["video"] != null &&
              blogController.blogData["video"].toString().isNotEmpty)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ChewieVideoPlayer(
                videoUrl:
                    "$s3_cdn/${Uri.encodeFull(blogController.blogData["video"])}",
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
                  if (blogController.blogData["video"] != null &&
                      blogController.blogData["video"]
                          .toString()
                          .isNotEmpty) ...[
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600))),
                    const SizedBox(height: 10)
                  ],
                  DeltaTextView(
                    deltaJson: blogController.blogData["content"] ?? "[]",
                    defaultStyle: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  //  else {
  //   return const Center(child: CircularProgressIndicator());
  // }
  // }
  //   ),
  // );
  // }
}
