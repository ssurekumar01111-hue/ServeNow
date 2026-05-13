import 'package:url_launcher/url_launcher.dart';
import 'package:handyman/features/jobs/data/models/booking_model.dart';

Future<void> navigateToCustomer(BookingModel job) async {
  final lat = job.customerLat;
  final lng = job.customerLng;

  print('Navigate to: lat=$lat lng=$lng');

  // Try Google Maps app first
  final googleMapsUrl = 'google.maps://maps.google.com/maps?daddr=$lat,$lng&travelmode=driving';
  
  // Fallback to browser Google Maps
  final browserUrl = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving';

  if (lat == 0.0 && lng == 0.0) {
    // No coordinates — use address instead
    final address = Uri.encodeComponent(job.customerAddress);
    final addressUrl = 'https://www.google.com/maps/dir/?api=1&destination=$address&travelmode=driving';

    if (await canLaunchUrl(Uri.parse(addressUrl))) {
      await launchUrl(Uri.parse(addressUrl), mode: LaunchMode.externalApplication);
    } else {
      // Show error (Note: In Riverpod, we might need a context or a snackbar service)
      print('Could not open maps for address: $address');
    }
    return;
  }

  // Try Google Maps app first
  if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
    await launchUrl(Uri.parse(googleMapsUrl), mode: LaunchMode.externalApplication);
  } else if (await canLaunchUrl(Uri.parse(browserUrl))) {
    // Fallback to browser
    await launchUrl(Uri.parse(browserUrl), mode: LaunchMode.externalApplication);
  } else {
    print('Could not open Google Maps.');
  }
}
