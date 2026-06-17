abstract class AppException implements Exception {
  const AppException({required this.message});

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException({required super.message});
}

final class AuthException extends AppException {
  const AuthException({required super.message});
}

final class CacheException extends AppException {
  const CacheException({required super.message});
}

final class UnexpectedException extends AppException {
  const UnexpectedException({required super.message});
}
