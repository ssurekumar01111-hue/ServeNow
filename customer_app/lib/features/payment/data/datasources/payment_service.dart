import 'package:customer/core/constants/keys.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  PaymentService() {
    _razorpay = Razorpay();
  }

  late Razorpay _razorpay;

  void openRazorpay({
    required double amount,
    required String contact,
    required String email,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) {
    final options = {
      'key': AppKeys.razorpayKeyId,
      'amount': (amount * 100).toInt(), // in paisa
      'name': 'ServeNow',
      'description': 'Booking Payment',
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
      onSuccess(response);
      _razorpay.clear();
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      onFailure(response);
      _razorpay.clear();
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
      _razorpay.clear();
    });

    _razorpay.open(options);
  }

  void dispose() {
    _razorpay.clear();
  }
}
