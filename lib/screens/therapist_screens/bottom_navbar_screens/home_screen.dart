import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/therapist/therapist_blogs_controller.dart';
import 'package:fsui/screens/therapist_screens/blog_editor_screen.dart';
import 'package:fsui/widgets/blog_card.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatelessWidget {
  final TherapistBlogsController blogsController =
      Get.put(TherapistBlogsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Manage Blogs",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showAddVideoDialog(context);
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text(
                      "Video Blogs",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mid,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(BlogEditorScreen());
                    },
                    icon: const Icon(Icons.article_outlined),
                    label: const Text(
                      "Publish Articles",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mid,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              if (blogsController.blogs.isEmpty) {
                return const Center(
                  child: Text(
                    "No videos added yet.",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              } else {
                return Expanded(
                  child: Obx(
                    () => blogsController.blogs.isEmpty
                        ? const Center(
                            child: Text('No blogs available'),
                          )
                        : ListView(
                            children: blogsController.blogs.map<Widget>((blog) {
                              return BlogCard(
                                id: blog.blogId,
                                imageUrl: blog.thumbnail ?? '',
                                title: blog.title,
                                subtitle: blog.description,
                                url: blog.title,
                              );
                            }).toList(),
                          ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  void _showAddVideoDialog(BuildContext context) {
    final headingController = TextEditingController();
    final descriptionController = TextEditingController();
    final urlController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    File? selectedThumbnail;
    RxString thumbnailName = 'Select Thumbnail'.obs;

    File? selectedVideo;
    RxString videoName = 'Select Video'.obs;

    Future<void> pickThumbnail() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        selectedThumbnail = File(result.files.single.path!);
        thumbnailName.value = result.files.single.name;
      }
    }

    Future<void> pickVideo() async {
      videoName.value = 'Uploading Video...';
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        selectedVideo = File(result.files.single.path!);
        videoName.value = result.files.single.name;
      }

      if (result == null || result.files.isEmpty) {
        CommonSnackbar.show(
          text: 'Invalid file',
          subtext: 'Please select a valid file',
          color: 'red',
        );
      }
    }

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
                      decoration: const InputDecoration(
                          labelText: "Title",
                          labelStyle: TextStyle(fontSize: 12)),
                      maxLength: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title cannot be empty";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      maxLength: 60,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description cannot be empty";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: urlController,
                      decoration: const InputDecoration(
                          labelText: "Content",
                          labelStyle: TextStyle(fontSize: 12)),
                      minLines: 1,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // Button to pick thumbnail image
                    ElevatedButton(
                      onPressed: pickThumbnail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.light100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        minimumSize: Size(double.infinity, 0),
                      ),
                      child: Obx(() {
                        return Text(thumbnailName.value);
                      }),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // Display selected file
                    selectedThumbnail != null
                        ? Image.file(selectedThumbnail!, width: 100)
                        : Container(),
                    selectedVideo != null
                        ? VideoPlayer(VideoPlayerController.file(
                            selectedVideo!,
                          ))
                        : Container(),

                    const SizedBox(
                      height: 15,
                    ),

                    // Button to pick video
                    ElevatedButton(
                      onPressed: pickVideo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.light100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        minimumSize: Size(double.infinity, 0),
                      ),
                      child: Obx(() {
                        return Text(videoName.value);
                      }),
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
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red[800]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final title = headingController.text.trim();
                  final description = descriptionController.text.trim();
                  final content = urlController.text.trim();

                  if (title.isEmpty ||
                      description.isEmpty ||
                      content.isEmpty ||
                      selectedThumbnail == null ||
                      selectedVideo == null) {
                    CommonSnackbar.show(
                      text: 'Incomplete fields',
                      subtext: "Please provide valid input fields",
                      color: 'red',
                    );
                    return;
                  }
                  final data = {
                    "title": title,
                    "description": description,
                    "content": content,
                  };

                  blogsController.createBlog(data).then((response) async {
                    if (response.statusCode == 201) {
                      final data = {
                        "thumbnail": selectedThumbnail?.path,
                        "video": selectedVideo?.path,
                      };
                      final responseData = jsonDecode(response.body);
                      final blogId = responseData['blog_id'];
                      await blogsController.uploadBlogData(data, blogId);
                    } else {
                      CommonSnackbar.show(
                        text: 'Error',
                        subtext:
                            'Something went wrong. Please try again later.',
                        color: 'red',
                      );
                    }
                  }).catchError((error) {
                    CommonSnackbar.show(
                      text: 'Error',
                      subtext: error.toString(),
                      color: 'red',
                    );
                  });
                } else {
                  CommonSnackbar.show(
                      text: 'Incomplete fields',
                      subtext: "Please provide valid input fields",
                      color: 'red');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mid,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Obx(() {
                return blogsController.isLoading.value == false
                    ? const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Uploading files',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        ],
                      );
              }),
            ),
          ],
        );
      },
    );
  }
}
