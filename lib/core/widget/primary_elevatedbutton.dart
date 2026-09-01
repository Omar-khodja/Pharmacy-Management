import 'package:flutter/material.dart';

class PrimaryElevatedbutton extends StatelessWidget {
  const PrimaryElevatedbutton({
    super.key,
    required this.title,
    required this.onClick,
    this.leadIcon,
    this.tailIcon,
  });
  final String title;
  final IconData? leadIcon;
  final IconData? tailIcon;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: .circular(12)),
          elevation: 4,
        ),

        onPressed: () => onClick(),
        child: Row(
          mainAxisSize: .min,
          children: [
            if (leadIcon != null) Icon(leadIcon),
            const SizedBox(width: 8),
             Text(title, style:const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            if (tailIcon != null) Icon(tailIcon),
          ],
        ),
      ),
    );
  }
}
