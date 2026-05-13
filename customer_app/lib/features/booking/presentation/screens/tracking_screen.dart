import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TrackingScreen extends StatefulWidget {
  final String bookingId;
  const TrackingScreen({super.key, required this.bookingId});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  StreamSubscription? _handymanSubscription;
  Marker? _handymanMarker;
  Marker? _customerMarker;
  Polyline? _routePolyline;
  bool _proximityNotified = false;
  
  BookingEntity? _booking;
  LatLng? _handymanPos;
  LatLng? _customerPos;
  String _eta = "Calculating...";
  String _distance = "";

  @override
  void initState() {
    super.initState();
    _loadBookingData();
  }

  @override
  void dispose() {
    _handymanSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadBookingData() async {
    final doc = await FirebaseFirestore.instance.collection('bookings').doc(widget.bookingId).get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _customerPos = LatLng(
          (data['customerLat'] as num? ?? 0.0).toDouble(),
          (data['customerLng'] as num? ?? 0.0).toDouble(),
        );
        _customerMarker = Marker(
          markerId: const MarkerId('customer'),
          position: _customerPos!,
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        );
      });
      _listenToHandymanLocation(data['handymanId'] as String?);
    }
  }

  void _listenToHandymanLocation(String? handymanId) {
    if (handymanId == null) return;
    _handymanSubscription = FirebaseFirestore.instance
        .collection('handymen')
        .doc(handymanId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists && snapshot.data()!.containsKey('location')) {
        final loc = snapshot.data()!['location'] as Map<String, dynamic>;
        final newPos = LatLng(
          (loc['lat'] as num).toDouble(),
          (loc['lng'] as num).toDouble(),
        );
        
        setState(() {
          _handymanPos = newPos;
          _handymanMarker = Marker(
            markerId: const MarkerId('handyman'),
            position: newPos,
            infoWindow: InfoWindow(title: (snapshot.data()!['name'] as String?) ?? 'Handyman'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          );
        });

        _updateMapBounds();
        _calculateEtaAndDistance();
        _checkProximity((snapshot.data()!['name'] as String?) ?? 'Handyman');
      }
    });
  }

  void _updateMapBounds() async {
    if (_handymanPos == null || _customerPos == null) return;
    final controller = await _controller.future;
    
    LatLngBounds bounds;
    if (_handymanPos!.latitude > _customerPos!.latitude) {
      bounds = LatLngBounds(southwest: _customerPos!, northeast: _handymanPos!);
    } else {
      bounds = LatLngBounds(southwest: _handymanPos!, northeast: _customerPos!);
    }
    
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  Future<void> _calculateEtaAndDistance() async {
    if (_handymanPos == null || _customerPos == null) return;
    
    final distMeters = Geolocator.distanceBetween(
      _handymanPos!.latitude, _handymanPos!.longitude,
      _customerPos!.latitude, _customerPos!.longitude
    );

    // Simplified ETA calculation (assuming 30km/h avg speed)
    final timeMinutes = (distMeters / 500).round(); 
    
    setState(() {
      _distance = "${(distMeters / 1000).toStringAsFixed(1)} km away";
      _eta = "Arriving in ~$timeMinutes mins";
    });
  }

  void _checkProximity(String handymanName) {
    if (_handymanPos == null || _customerPos == null || _proximityNotified) return;
    
    final distance = Geolocator.distanceBetween(
      _handymanPos!.latitude, _handymanPos!.longitude,
      _customerPos!.latitude, _customerPos!.longitude
    );

    if (distance < 500) {
      _proximityNotified = true;
      _showProximityNotification(handymanName);
    }
  }

  Future<void> _showProximityNotification(String name) async {
    const android = AndroidNotificationDetails(
      'proximity',
      'Proximity',
      channelDescription: 'Handyman proximity notifications',
      importance: Importance.max,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);
    
    await FlutterLocalNotificationsPlugin().show(
      id: 999, 
      title: 'Handyman is nearby!', 
      body: '$name is less than 500m away. Get ready!', 
      notificationDetails: details,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Handyman')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _customerPos ?? const LatLng(0, 0), zoom: 15),
            onMapCreated: (controller) => _controller.complete(controller),
            markers: {
              if (_customerMarker != null) _customerMarker!,
              if (_handymanMarker != null) _handymanMarker!,
            },
            polylines: _routePolyline != null ? {_routePolyline!} : {},
          ),
          if (_proximityNotified)
            Positioned(
              top: 10,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Handyman is almost there!',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 30, child: Icon(Icons.person)),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Handyman Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(' 4.8'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(20)),
                child: const Text('On the Way', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: Colors.grey),
              const SizedBox(width: 10),
              Text('$_eta · $_distance', style: const TextStyle(fontSize: 16)),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _launchCaller(),
                  icon: const Icon(Icons.phone),
                  label: const Text('Call'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to Chat
                  },
                  icon: const Icon(Icons.chat),
                  label: const Text('Chat'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchCaller() async {
    // We'll get this from booking later
    const phone = "1234567890";
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
