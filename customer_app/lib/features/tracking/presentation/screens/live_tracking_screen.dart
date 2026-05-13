import 'package:customer/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackingScreen extends ConsumerStatefulWidget {
  const LiveTrackingScreen({
    required this.handymanId,
    required this.handymanName,
    required this.customerAddress,
    super.key,
  });

  final String handymanId;
  final String handymanName;
  final LatLng customerAddress;

  @override
  ConsumerState<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  GoogleMapController? _mapController;
  Marker? _handymanMarker;

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(handymanLocationProvider(widget.handymanId));

    return Scaffold(
      appBar: AppBar(title: Text('Tracking ${widget.handymanName}')),
      body: Stack(
        children: [
          locationAsync.when(
            data: (location) {
              final handymanPos = LatLng(location.latitude, location.longitude);
              
              _handymanMarker = Marker(
                markerId: const MarkerId('handyman'),
                position: handymanPos,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(title: widget.handymanName),
              );

              // Smooth animation would typically use a Tween and setState
              // but for this stub we'll just move the camera
              _mapController?.animateCamera(CameraUpdate.newLatLng(handymanPos));

              return GoogleMap(
                initialCameraPosition: CameraPosition(target: handymanPos, zoom: 15),
                onMapCreated: (controller) => _mapController = controller,
                markers: {
                  _handymanMarker!,
                  Marker(markerId: const MarkerId('customer'), position: widget.customerAddress),
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(widget.handymanName),
                      subtitle: const Text('En Route'),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () {},
                      ),
                    ),
                    const Text('Estimated Arrival: 10 mins', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
