import 'package:flutter/material.dart';

class CustomIconbutton extends StatelessWidget {
  const CustomIconbutton({
    super.key,
    this.color,
    this.iconColor,
    required this.icon,
    required this.onTab,
  });
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final Function onTab;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onTab(),
      icon: Icon(icon,color:  iconColor ?? Colors.black,),
      style: IconButton.styleFrom(
        backgroundColor: color ?? Colors.transparent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(3),
          side:const   BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
    );
  }
}
