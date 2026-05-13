// stub class — replace with real implementation after adding Razorpay keys
// See Firebase Setup Guide included in the package

class RazorpayService {
  // TODO(buyer): Implement after adding Razorpay credentials
  // 1. Get your Key ID from Razorpay Dashboard
  // 2. Add Key ID to AppKeys class in lib/core/constants/keys.dart
  // 3. Uncomment razorpay_flutter in pubspec.yaml
  // 4. Implement methods below following razorpay_flutter documentation

  void init({
    required Function(dynamic) onSuccess,
    required Function(dynamic) onFailure,
    required Function(dynamic) onWallet,
  }) {
    // Stub implementation
  }

  void dispose() {
    // Stub implementation
  }

  Future<void> openCheckout({
    required double amount,
    required String orderId,
    required String customerName,
    required String customerPhone,
    required String customerEmail,
    required String description,
  }) async {
    // Not implemented — see setup guide
  }

  Future<String> createOrder({
    required double amount,
    required String receipt,
  }) async {
    // This will now hit the placeholder Cloud Function
    return 'placeholder_order_id';
  }
}
