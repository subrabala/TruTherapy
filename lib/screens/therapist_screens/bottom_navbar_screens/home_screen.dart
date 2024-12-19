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
        automaticallyImplyLeading : false,
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
  final formKey = GlobalKey<FormState>(); // For validation

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Rounded corners
        ),
        title: const Text("Add New Video"),
        content: Container(
          width: 450, // Custom width
          height: 300, // Custom height
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: headingController,
                    decoration: const InputDecoration(labelText: "Heading", labelStyle: TextStyle(fontSize: 12)),
                    maxLength: 30, // Restrict input length
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Heading cannot be empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: "Description",labelStyle: TextStyle(fontSize: 12)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Description cannot be empty";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: urlController,
                    decoration: const InputDecoration(labelText: "Video URL or File Path", labelStyle: TextStyle(fontSize: 12)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Video URL cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
                Get.back();
            },
            child:  Text("Cancel", style: TextStyle(color: Colors.red[800]),),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) { // Check validation
                videoController.addVideo(
                  headingController.text,
                  descriptionController.text,
                  urlController.text,
                );
                Get.back();
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    },
  );

}

}
