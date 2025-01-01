import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoController;
  var isPlaying = false.obs;
  var isInitialized = false.obs;
  var videoPosition = 0.0.obs;

  void initializeVideo(String videoUrl, {Duration? seekToDuration}) {
    videoController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        if (seekToDuration != null) {
          videoController.seekTo(seekToDuration);
        }
        isInitialized.value = true;
        update(); 
      });

    videoController.addListener(() {
      if (videoController.value.isInitialized) {
        videoPosition.value = videoController.value.position.inMilliseconds.toDouble();
        update(); 
      }
    });
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      videoController.pause();
    } else {
      videoController.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  // Seek to a specific position in the video
  void seekTo(double value) {
    final position = Duration(milliseconds: value.toInt());
    videoController.seekTo(position);
  }

  @override
  void onClose() {
    videoController.dispose(); // Dispose of the video controller when the controller is closed
    super.onClose();
  }
}
