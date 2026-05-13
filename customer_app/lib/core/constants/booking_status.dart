class BookingStatuses {
  // Use these EXACT strings everywhere
  // Must match customer_app and Firestore exactly
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String assigned = 'assigned';
  static const String enRoute = 'en_route';
  static const String arrived = 'arrived';
  static const String inProgress = 'in_progress';
  static const String completed = 'completed';
  static const String cancelled = 'cancelled';

  // All active statuses
  static const List<String> activeStatuses = [
    enRoute,
    arrived,
    inProgress,
  ];

  // All terminal statuses
  static const List<String> terminalStatuses = [
    completed,
    cancelled,
  ];
}
