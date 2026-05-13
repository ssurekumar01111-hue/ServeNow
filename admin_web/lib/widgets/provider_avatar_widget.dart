import 'package:flutter/material.dart';
import 'package:admin_web/app/models/provider_model.dart';
import 'package:admin_web/widgets/safe_avatar_widget.dart';

class ProviderAvatar extends StatelessWidget {
  final ProviderModel provider;
  final double radius;

  const ProviderAvatar({
    Key? key,
    required this.provider,
    this.radius = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeAvatar(
      imageUrl: provider.photoUrl,
      fallbackInitial: provider.businessName.isNotEmpty
          ? provider.businessName[0]
          : 'P',
      radius: radius,
    );
  }
}
