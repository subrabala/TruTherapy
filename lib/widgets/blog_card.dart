import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/user/blogs_controller.dart';
import 'package:fsui/controllers/therapist/therapist_blogs_controller.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/screens/blogs_video_player_screen.dart';
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
      color: PastelColors.seaBlue.withOpacity(0.4),
      elevation: 0,
      borderOnForeground: false,
      shadowColor: AppColors.light100.withOpacity(0.5),
      surfaceTintColor: AppColors.light100.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          getScope() == 'therapist'
              ? Get.find<TherapistBlogsController>()
                  .fetchBlogData(id.toString())
              : Get.find<BlogsController>().fetchBlogData(id.toString());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Left side for image
            Expanded(
              flex: 1,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  '$s3_cdn/$imageUrl',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/fallback_blog.png",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 5, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark800,
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
          ],
        ),
      ),
    );
  }
}
