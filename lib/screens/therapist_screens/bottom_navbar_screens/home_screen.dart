import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/video_controller.dart';
import 'package:fsui/webview.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading : false,
        title: const Text("Manage Blogs", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
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
                color: PastelColors.seaBlue.withOpacity(0.5),
                elevation: 0,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.play_circle_outline_outlined, color: Colors.blue.shade400),
                  title: Text(video.heading),
                  subtitle: Text(video.description),
                  trailing: IconButton(
                    icon:  Icon(Icons.delete, color: Colors.red[200]),
                    onPressed: () {
                      videoController.deleteVideo(video.id);
                    },
                  ),
                  onTap: () {
                     Get.to(() => WebViewPage(url: "https://www.youtube.com/watch?v=vM2dC8OCZoY"));
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
  final formKey = GlobalKey<FormState>(); 

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), 
        ),
        title: const Text("Add New Video"),
        content: Container(
          width: 450, 
          height: 300,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: headingController,
                    decoration: const InputDecoration(labelText: "Heading", labelStyle: TextStyle(fontSize: 12)),
                    maxLength: 30,
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
                      if (value == null || value.isEmpty || !value.contains("https://")) {
                        return "Invalid video URL";
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
              if (formKey.currentState!.validate()) { 
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
