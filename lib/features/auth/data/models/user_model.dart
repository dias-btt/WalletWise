import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:wallet_wise/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel extends User with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'currency_code') required String currencyCode,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _UserModel;

  const UserModel._({
    required super.id,
    required super.email,
    required super.displayName,
    required super.currencyCode,
    required super.createdAt,
    super.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSupabaseUser(supabase.User user) {
    final Map<String, dynamic> metadata = user.userMetadata ?? <String, dynamic>{};
    final String createdAtRaw = user.createdAt;

    return UserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: metadata['display_name'] as String? ??
          user.email?.split('@').first ??
          '',
      avatarUrl: metadata['avatar_url'] as String?,
      currencyCode: metadata['currency_code'] as String? ?? 'USD',
      createdAt: DateTime.parse(createdAtRaw),
    );
  }
}
