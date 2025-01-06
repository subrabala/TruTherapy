import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/therapist/therapist_blogs_controller.dart';
import 'package:fsui/widgets/blog_card.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddVideoDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: Obx(() {
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
                            imageUrl: blog.thumbnail,
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
      ),
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

                  final data = {
                    "title": title,
                    "description": description,
                    "content": content,
                  };
                  blogsController.createBlog(data);
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
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        );
      },
    );
  }
}
