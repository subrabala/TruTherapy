import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color darkColor;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  // Constructor to accept all the parameters
  const GenderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.darkColor,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? darkColor.withOpacity(0.8) : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.white : darkColor,
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : darkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
