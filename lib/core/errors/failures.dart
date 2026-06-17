import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

final class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

final class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

final class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message});
}
