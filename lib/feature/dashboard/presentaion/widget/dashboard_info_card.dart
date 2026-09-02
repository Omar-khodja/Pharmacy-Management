import 'package:flutter/material.dart';

class DashboardInfoCard extends StatelessWidget {
  const DashboardInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.isError = false,
  });
  final String title;
  final String value;
  final IconData icon;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isError ? const Color(0xFF842029) : Colors.transparent,
        ),
      ),
      elevation: isError ? 6 : 2,
      color: isError
          ? Theme.of(context).colorScheme.error.withValues(alpha: 0.8)
          : Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isError
                        ? Theme.of(context).colorScheme.onError
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  icon,
                  color: isError
                      ? Theme.of(context).colorScheme.onError
                      : Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: isError
                    ? Theme.of(context).colorScheme.onError
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
