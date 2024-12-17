import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const BlogCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.light100.withOpacity(0.5),
      elevation: 0,
      borderOnForeground: false,
      shadowColor: AppColors.light100,
      surfaceTintColor: AppColors.light100,
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
              borderRadius:const  BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(    
                  imageUrl,            
                  fit: BoxFit.cover,
                  height: 110, 
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2, 
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
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
          IconButton(
            icon: const Icon(Icons.arrow_outward, color: AppColors.mid),
            iconSize: 20,
            onPressed: () {
              
            },
          ),
        ],
      ),
    );
  }
}
