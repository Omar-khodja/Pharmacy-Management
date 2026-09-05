import 'package:flutter/material.dart';

class TextBedge extends StatelessWidget {
  const TextBedge({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });
  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
      avatar: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
