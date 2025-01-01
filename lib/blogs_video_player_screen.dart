import 'package:flutter/material.dart';
import 'package:fsui/controllers/video_player_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class BlogsVideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  BlogsVideoPlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.isRegistered<VideoController>()
        ? Get.find<VideoController>()
        : Get.put(VideoController());

    controller.initializeVideo(videoUrl);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (controller.isInitialized.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: controller.videoController.value.aspectRatio,
                  child: VideoPlayer(controller.videoController),
                ),
                SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: () {
                    // Toggle play/pause on button click
                    controller.togglePlayPause();
                  },
                  child: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
