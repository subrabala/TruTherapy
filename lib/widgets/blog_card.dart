import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/blogs_controller.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/blogs_video_player_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BlogCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String url;

  const BlogCard({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.light100.withOpacity(0.3),
      elevation: 0,
      borderOnForeground: false,
      shadowColor: AppColors.light100.withOpacity(0.5),
      surfaceTintColor: AppColors.light100.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Left side for image
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Opacity(
                  opacity: 0.9,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 90,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/fallback_blog.png",
                        fit: BoxFit.cover,
                        height: 90,
                      );
                    },
                  )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark800.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.dark800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_outward, color: AppColors.mid),
            iconSize: 20,
            onPressed: () {
              Get.find<BlogsController>().fetchResources(id.toString());
            },
          ),
        ],
      ),
    );
  }
}
