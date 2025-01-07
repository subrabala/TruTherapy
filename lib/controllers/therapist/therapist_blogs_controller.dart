import 'dart:convert';
import 'dart:io';

import 'package:fsui/constants.dart';
import 'package:fsui/models.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/screens/blogs_video_player_screen.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TherapistBlogsController extends BaseBlogsController {
  var blogs = <Blogs>[].obs;
  String resourceUrl = "";
  RxBool isLoading = false.obs;

  Map<String, dynamic> blogData = {};

  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      final jwt = getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/therapist/blogs/all'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);

        blogs.value = jsonList
            .map((jsonItem) => Blogs.fromJson(jsonItem as Map<String, dynamic?>))
            .toList();
      } else {
        CommonSnackbar.show(
          text: "Error fetching blogs",
          subtext: response.body,
          color: "red",
        );
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
      final jwt = getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/therapist/blogs/$blogId'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        blogData = jsonDecode(response.body);

        Get.to(() => BlogsVideoPlayerScreen());
      } else {
        CommonSnackbar.show(
          text: "Error fetching blog",
          subtext: response.body,
          color: "red",
        );
      }
    } catch (e) {
      CommonSnackbar.show(
          text: "Error fetching blogs", subtext: e.toString(), color: "red");
    }
  }

  Future<http.Response> createBlog(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final jwt = getJwt();
      final response = await http.post(
        Uri.parse('$backendUrl/blogs/create'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      return response;
    } catch (e) {
      CommonSnackbar.show(
        text: "Failed to create blog",
        subtext: e.toString(),
        color: "red",
      );
      rethrow;
    }
  }

  Future<void> uploadBlogData(Map<String, dynamic> data, int blogId) async {
    try {
      final jwt = getJwt();
      var uri = Uri.parse('$backendUrl/blogs/create/${blogId.toString()}');
      var request = http.MultipartRequest('PUT', uri)
        ..headers.addAll({'Authorization': 'Bearer $jwt'});

      File videoFile = File(data['video']);
      List<int> videoBytes = await videoFile.readAsBytes();

      File thumbnailFile = File(data['thumbnail']);
      List<int> thumbnailBytes = await thumbnailFile.readAsBytes();

      request.files.add(http.MultipartFile.fromBytes('video', videoBytes,
          filename: 'video.mp4'));
      request.files.add(http.MultipartFile.fromBytes(
          'thumbnail', thumbnailBytes,
          filename: 'thumbnail.jpg'));

      var response = await request.send();
      var responseData = await response.stream.toBytes();


      if (response.statusCode != 201) {
        CommonSnackbar.show(
            text: "Error uploading blog", subtext: '', color: "red");
      } else if (response.statusCode == 201) {
        Get.back();
        CommonSnackbar.show(
            text: "Created blog successfully", subtext: '', color: "green");
      }
    } catch (e) {
      CommonSnackbar.show(
          text: "Error creating blog", subtext: e.toString(), color: "red");
    } finally {
      isLoading.value = false;
    }
  }
}

class Blogs {
  final int blogId;
  final String title;
  final String description;
  final String? thumbnail;
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
