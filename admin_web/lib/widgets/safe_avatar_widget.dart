import 'package:flutter/material.dart';
import 'package:admin_web/app/utils/app_colors.dart';

class SafeAvatar extends StatelessWidget {
  final String? imageUrl;
  final String fallbackInitial;
  final double radius;
  final IconData? fallbackIcon;

  const SafeAvatar({
    Key? key,
    this.imageUrl,
    this.fallbackInitial = '?',
    this.radius = 28,
    this.fallbackIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    if (!hasImage) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.primaryLight,
        child: fallbackIcon != null
            ? Icon(fallbackIcon, size: radius, color: AppColors.primary)
            : Text(fallbackInitial.toUpperCase(),
                style: TextStyle(
                    fontSize: radius * 0.7,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primaryLight,
      child: ClipOval(
        child: Image.network(
          imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => fallbackIcon != null
              ? Icon(fallbackIcon, size: radius, color: AppColors.primary)
              : Text(fallbackInitial.toUpperCase(),
                  style: TextStyle(
                      fontSize: radius * 0.7,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
          loadingBuilder: (context, child, progress) => progress == null
              ? child
              : SizedBox(
                  width: radius * 2,
                  height: radius * 2,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
        ),
      ),
    );
  }
}
