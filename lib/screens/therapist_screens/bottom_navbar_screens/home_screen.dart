import 'package:flutter/material.dart';
import 'package:fsui/controllers/video_controller.dart';
import 'package:fsui/screens/therapist_screens/bottom_navbar_screens/video_details_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Videos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddVideoDialog(context);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (videoController.videos.isEmpty) {
          return const Center(
            child: Text(
              "No videos added yet.",
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: videoController.videos.length,
            itemBuilder: (context, index) {
              final video = videoController.videos[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.video_library, color: Colors.blue.shade400),
                  title: Text(video.heading),
                  subtitle: Text(video.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      videoController.deleteVideo(video.id);
                    },
                  ),
                  onTap: () {
                    Get.to(() => VideoDetailScreen(video: video));
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _showAddVideoDialog(BuildContext context) {
    final headingController = TextEditingController();
    final descriptionController = TextEditingController();
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Video"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: headingController,
                  decoration: const InputDecoration(labelText: "Heading"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(labelText: "Video URL or File Path"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                videoController.addVideo(
                  headingController.text,
                  descriptionController.text,
                  urlController.text,
                );
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
