class ServerException implements Exception {
  const ServerException([this.message = 'Server Exception']);
  final String message;
}

class CacheException implements Exception {
  const CacheException([this.message = 'Cache Exception']);
  final String message;
}
