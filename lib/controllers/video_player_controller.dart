import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoController;
  var isPlaying = false.obs;
  var isInitialized = false.obs;
  var videoPosition = 0.0.obs;

  VideoPlayerOptions videoOptions = VideoPlayerOptions(
    webOptions: const VideoPlayerWebOptions(
      controls: VideoPlayerWebOptionsControls.enabled(
        allowDownload: true,
        allowFullscreen: true,
        allowPlaybackRate: true,
        allowPictureInPicture: true,
      ),
    ),
  );

  void initializeVideo(String videoUrl, {Duration? seekToDuration}) {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl),
        videoPlayerOptions: videoOptions)
      ..initialize().then((_) {
        isInitialized.value = true;
        update();
      });

    videoController.addListener(() {
      if (videoController.value.isInitialized) {
        videoPosition.value =
            videoController.value.position.inMilliseconds.toDouble();
        update();
      }
    });

    if (seekToDuration != null) {
      seekTo(seekToDuration.inMilliseconds.toDouble());
    }
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      videoController.pause();
    } else {
      videoController.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  void seekTo(double value) {
    final position = Duration(milliseconds: value.toInt());
    videoController.seekTo(position);
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
