import 'package:customer/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ServiceImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final Color? placeholderColor;
  final IconData? placeholderIcon;

  const ServiceImageWidget({
    super.key,
    this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius,
    this.placeholderColor,
    this.placeholderIcon,
  });

  bool get _isValidUrl {
    if (imageUrl == null || imageUrl!.isEmpty) return false;
    try {
      final uri = Uri.parse(imageUrl!);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = placeholderColor ?? AppColors.primary;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: _isValidUrl
          ? Image.network(
              imageUrl!,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _buildPlaceholder(color),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: width,
                  height: height,
                  color: color.withOpacity(0.05),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            )
          : _buildPlaceholder(color),
    );
  }

  Widget _buildPlaceholder(Color color) {
    return Container(
      width: width,
      height: height,
      color: color.withOpacity(0.1),
      child: Icon(
        placeholderIcon ?? Icons.home_repair_service_rounded,
        color: color,
        size: width * 0.4,
      ),
    );
  }
}
