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
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final String? url;

  const BlogCard({
    Key? key,
    required this.id,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.url,
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
                borderRadius: BorderRadius.circular(8),
                child: imageUrl != null 
                    ? Image.network(
                        '$s3_cdn/$imageUrl',
                        fit: BoxFit.cover,
                        height: 80,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 80,
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / 
                                      loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image_not_supported_outlined, 
                                     color: Colors.grey[400],
                                     size: 24),
                                const SizedBox(height: 4),
                                Text(
                                  'No Image',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_library_outlined, 
                                 color: Colors.grey[400],
                                 size: 24),
                            const SizedBox(height: 4),
                            Text(
                              'No Preview',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
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
                      title?.isNotEmpty == true ? title! : 'Untitled Blog',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark800,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    if (subtitle?.isNotEmpty == true)
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.dark800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    else
                      Text(
                        'No description available',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
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
