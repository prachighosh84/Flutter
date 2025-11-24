import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> channels = [
      "Channel 1",
      "Channel 2",
      "Channel 3",
      "Channel 4",
    ];

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: channels.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.tag, size: 22, color: Colors.grey.shade700),
                      const SizedBox(width: 12),
                      Text(
                        channels[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
