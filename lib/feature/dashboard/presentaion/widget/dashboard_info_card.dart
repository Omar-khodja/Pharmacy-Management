import 'package:flutter/material.dart';

class DashboardInfoCard extends StatelessWidget {
  const DashboardInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
     this.backgroundColor,
  });
  final String title;
  final String value;
  final IconData icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color:backgroundColor != null?const Color(0xFF842029): Colors.grey.shade300)),
      elevation: 4,
      color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.all(8.0),

      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style:  TextStyle(fontSize: 16,color: backgroundColor != null?const  Color(0xFF842029): Colors.black,fontWeight: FontWeight.bold),),
                Icon(icon,color: backgroundColor != null
                      ? const Color(0xFF842029)
                      : Theme.of(context).colorScheme.primary,size: 30,),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              value,
              style:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: backgroundColor != null
                    ? const Color(0xFF842029)
                    : Colors.black,
              ),
            ),
          ],
        )
      ),
    );
  }
}
