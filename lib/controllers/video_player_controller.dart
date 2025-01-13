import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  
  var isPlaying = false.obs;
  var isInitialized = false.obs;
  var videoPosition = 0.0.obs;

  void initializeVideo(String videoUrl, {Duration? seekToDuration}) {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        isInitialized.value = true;
        update();
      });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      errorBuilder: (context, errorMessage) {
        return Center(child: Text(errorMessage));
      },
    );

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.isInitialized) {
        videoPosition.value = videoPlayerController.value.position.inMilliseconds.toDouble();
        update();
      }
    });

    if (seekToDuration != null) {
      seekTo(seekToDuration.inMilliseconds.toDouble());
    }
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  void seekTo(double value) {
    final position = Duration(milliseconds: value.toInt());
    videoPlayerController.seekTo(position);
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}
