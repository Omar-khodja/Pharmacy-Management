import 'package:flutter/material.dart';

class PrimaryElevatedbutton extends StatelessWidget {
  const PrimaryElevatedbutton({
    super.key,
    required this.title,
    required this.onClick,
    this.leadIcon,
    this.tailIcon,
    this.isPrimary = true,
  });
  final String title;
  final IconData? leadIcon;
  final IconData? tailIcon;
  final Function onClick;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:isPrimary ? Theme.of(context).colorScheme.primary:null,
          foregroundColor:isPrimary? Theme.of(context).colorScheme.onPrimary:null,
          shape: RoundedRectangleBorder(borderRadius: .circular(12)),
          elevation: 4,
        ),

        onPressed: () => onClick(),
        child: Row(
          mainAxisSize: .min,
          children: [
            if (leadIcon != null) Icon(leadIcon),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            if (tailIcon != null) Icon(tailIcon),
          ],
        ),
      ),
    );
  }
}
