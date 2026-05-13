sealed class Failure {
  const Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Failure']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network Failure']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication Failure']);
}

class FirestoreFailure extends Failure {
  const FirestoreFailure([super.message = 'Firestore Failure']);
}
