import 'dart:convert';

import 'package:fsui/constants.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/blogs_video_player_screen.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class BlogsController extends GetxController {
  List<Blogs> blogs = <Blogs>[];
  String resourceUrl = "";

  @override
  void onInit() {
    super.onInit();
    fetchAllBlogs();
  }

  Future<void> fetchAllBlogs() async {
    try {
      final jwt = await getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/blogs/all'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);

        blogs = jsonList
            .map((jsonItem) => Blogs.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      CommonSnackbar.show(
          text: "Error fetching blogs", subtext: e.toString(), color: "red");
    }
  }

  Future<void> fetchResources(String resourceId) async {
    try {
      final jwt = await getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/blogs/resources/$resourceId'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String resourceUrl = data["resource_url"];
        Get.to(() => BlogsVideoPlayerScreen(videoUrl: resourceUrl));
      }
    } catch (e) {
      CommonSnackbar.show(
          text: "Error fetching blogs", subtext: e.toString(), color: "red");
    }
  }
}

class Blogs {
  final int blogId;
  final String title;
  final String description;
  final String thumbnail;
  final String status;

  Blogs({
    required this.blogId,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.status,
  });

  factory Blogs.fromJson(Map<String, dynamic> json) {
    return Blogs(
      blogId: json['blog_id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blog_id': blogId,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'status': status,
    };
  }
}
