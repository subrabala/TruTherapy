import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/models.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/screens/blogs_video_player_screen.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BlogsController extends BaseBlogsController {
  var blogs = <Blogs>[].obs;
  String resourceUrl = "";

  final blogData = RxMap<String, dynamic>({});
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

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
        try {
          final dynamic decodedData = jsonDecode(response.body);
          if (decodedData is! List) {
            throw FormatException('Expected a list of blogs');
          }
          final List<dynamic> jsonList = decodedData;

          blogs.value = jsonList
              .map((jsonItem) {
                try {
                  if (jsonItem is! Map<String, dynamic>) {
                    throw FormatException('Invalid blog format');
                  }
                  return Blogs.fromJson(jsonItem);
                } catch (e) {
                  debugPrint('Error parsing blog: $e');
                  return Blogs(
                    blogId: 0,
                    title: 'Error Loading Blog',
                    description: 'Failed to load blog data',
                    thumbnail: null,
                    status: 'error'
                  );
                }
              })
              .toList();
          
        } catch (e) {
          hasError.value = true;
          errorMessage.value = 'Invalid data format: ${e.toString()}';
          blogs.value = [];
        }
      } else {
        hasError.value = true;
        errorMessage.value = 'Server returned ${response.statusCode}';
        blogs.value = [];
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      blogs.value = [];
      CommonSnackbar.show(
        text: "Error fetching blogs",
        subtext: e.toString(),
        color: "red",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBlogData(String blogId) async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    
    try {
      final jwt = getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/blogs/$blogId'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        blogData.assignAll({
          'title': responseData['title']?.toString() ?? 'Untitled Blog',
          'created_at': responseData['created_at']?.toString() ?? DateTime.now().toIso8601String(),
          'video': responseData['video']?.toString() ?? '',
          'content': responseData['content']?.toString() ?? '[]',
          'description': responseData['description']?.toString() ?? '',
          'blog_id': responseData['blog_id']?.toString() ?? '0',
          'status': responseData['status']?.toString() ?? 'published',
        });
        
        Get.to(() => BlogsVideoPlayerScreen());
      } else {
        hasError.value = true;
        errorMessage.value = 'Failed to load blog: Server returned ${response.statusCode}';
        CommonSnackbar.show(
          text: "Error fetching blog",
          subtext: "Server returned ${response.statusCode}",
          color: "red",
        );
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      CommonSnackbar.show(
        text: "Error fetching blog",
        subtext: e.toString(),
        color: "red",
      );
    } finally {
      isLoading.value = false;
    }
  }

}

class Blogs {
  final int blogId;
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? status;

  Blogs({
    required this.blogId,
    this.title,
    this.description,
    this.thumbnail,
    this.status,
  });

  factory Blogs.fromJson(Map<String, dynamic> json) {
    return Blogs(
      blogId: json['blog_id'] as int? ?? 0, // Fallback to 0 if null
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      thumbnail: json['thumbnail']?.toString(),
      status: json['status']?.toString(),
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
