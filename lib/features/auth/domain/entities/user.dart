import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.currencyCode,
    required this.createdAt,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String displayName;
  final String? avatarUrl;
  final String currencyCode;
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        email,
        displayName,
        avatarUrl,
        currencyCode,
        createdAt,
      ];
}
