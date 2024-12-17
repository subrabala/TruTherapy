import 'package:get/get.dart';

class Video {
  final String id;
  final String heading;
  final String description;
  final String videoUrl;

  Video({
    required this.id,
    required this.heading,
    required this.description,
    required this.videoUrl,
  });
}

class VideoController extends GetxController {
  
  // List of videos managed as an observable list
  var videos = <Video>[].obs;

  // Add a new video
  void addVideo(String heading, String description, String videoUrl) {
    videos.add(Video(
      id: DateTime.now().toString(),
      heading: heading,
      description: description,
      videoUrl: videoUrl,
    ));
  }

  // Delete a video by its ID
  void deleteVideo(String id) {
    videos.removeWhere((video) => video.id == id);
  }
}
