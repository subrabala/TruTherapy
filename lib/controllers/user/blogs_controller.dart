import 'dart:convert';

import 'package:fsui/constants.dart';
import 'package:fsui/models.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/screens/blogs_video_player_screen.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class BlogsController extends BaseBlogsController {
  var blogs = <Blogs>[].obs;
  String resourceUrl = "";

  Map<String, dynamic> blogData = {};

  @override
  void onInit() {
    super.onInit();
    fetchAllBlogs();
  }

  Future<void> fetchAllBlogs() async {
    try {
      final jwt =  getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/blogs/all'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);

        blogs.value = jsonList
            .map((jsonItem) => Blogs.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      CommonSnackbar.show(
        text: "Error fetching blogs",
        subtext: e.toString(),
        color: "red",
      );
    }
  }

  Future<void> fetchBlogData(String blogId) async {
    try {
      final jwt =  getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/blogs/$blogId'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        blogData = jsonDecode(response.body);
        
        Get.to(() => BlogsVideoPlayerScreen());
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
