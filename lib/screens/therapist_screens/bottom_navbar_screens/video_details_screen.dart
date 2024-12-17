import 'package:flutter/material.dart';
import 'package:fsui/controllers/video_controller.dart';

class VideoDetailScreen extends StatelessWidget {
  final Video video;

  const VideoDetailScreen({required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              video.heading,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(video.description),
            const SizedBox(height: 16),
            const Text(
              "Video URL/Path:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(video.videoUrl),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add logic to play video
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Playing video...")),
                );
              },
              child: const Text("Play Video"),
            ),
          ],
        ),
      ),
    );
  }
}
