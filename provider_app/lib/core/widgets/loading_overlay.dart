import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({required this.child, required this.isLoading, super.key});

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const ColoredBox(
            color: Colors.black26,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
