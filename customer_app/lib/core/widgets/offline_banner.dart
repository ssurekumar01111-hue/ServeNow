import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final results = snapshot.data ?? [];
        final isOffline = results.isNotEmpty && results.contains(ConnectivityResult.none) && results.length == 1;

        if (isOffline) {
          return Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: const Text(
              'No Internet Connection',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
