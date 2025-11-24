import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  final Color color;

  const CardWidget({super.key ,  required this.icon,
    required this.title,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align left
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: color), // Icon
            const SizedBox(height: 12),                // Spacing
            Text(
              title,

              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );

  }
}
