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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Left side for image
          Expanded(
            flex: 1, // One-third of the card
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Opacity(
                opacity: 0.9,
                child: Image.network(                
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.dark800,
                    ),
                  ),
                  const SizedBox(height: 5), 
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.dark800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_outward),
            onPressed: () {
              
            },
          ),
        ],
      ),
    );
  }
}
