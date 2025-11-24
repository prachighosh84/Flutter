import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchWidget({
    super.key,
    this.hintText = "Search...",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
