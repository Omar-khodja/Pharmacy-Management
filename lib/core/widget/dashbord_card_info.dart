import 'package:flutter/material.dart';
class DashboardInfoCard extends StatelessWidget {
  const DashboardInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.isError = false,
    this.ontap,
  });

  final String title;
  final String value;
  final IconData icon;
  final bool isError;
  
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: isError? 6:4,
        shadowColor: isError? Colors.red.withValues(alpha:1): Colors.black.withValues(alpha: .5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isError
            ? colorScheme.errorContainer
            : colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isError
                          ? colorScheme.onErrorContainer
                          : colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isError ? colorScheme.error : colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isError
                      ? colorScheme.onErrorContainer
                      : colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
