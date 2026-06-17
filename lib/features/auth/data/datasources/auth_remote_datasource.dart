import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signInWithPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String displayName,
    required String currencyCode,
  });

  Future<void> signOut();

  Future<UserModel?> getCurrentUser();

  Stream<UserModel?> authStateChanges();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl(this._client);

  final supabase.SupabaseClient _client;

  static const String _usersTable = 'users';

  @override
  Future<UserModel> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final supabase.AuthResponse response =
          await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final supabase.User? user = response.user;
      if (user == null) {
        throw const AuthAppException(message: 'Sign in failed. Please try again.');
      }

      return await _fetchUserProfile(user.id) ??
          UserModel.fromSupabaseUser(user);
    } on supabase.AuthException catch (error) {
      throw AuthAppException(message: error.message);
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String displayName,
    required String currencyCode,
  }) async {
    try {
      final supabase.AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
        data: <String, dynamic>{
          'display_name': displayName,
          'currency_code': currencyCode,
        },
      );

      final supabase.User? user = response.user;
      if (user == null) {
        throw const AuthAppException(message: 'Sign up failed. Please try again.');
      }

      final DateTime createdAt = DateTime.now().toUtc();
      final Map<String, dynamic> userRow = <String, dynamic>{
        'id': user.id,
        'email': email,
        'display_name': displayName,
        'currency_code': currencyCode,
        'created_at': createdAt.toIso8601String(),
      };

      await _client.from(_usersTable).upsert(userRow);

      return UserModel(
        id: user.id,
        email: email,
        displayName: displayName,
        currencyCode: currencyCode,
        createdAt: createdAt,
      );
    } on supabase.AuthException catch (error) {
      throw AuthAppException(message: error.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on supabase.AuthException catch (error) {
      throw AuthAppException(message: error.message);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final supabase.User? user = _client.auth.currentUser;
    if (user == null) {
      return null;
    }

    try {
      return await _fetchUserProfile(user.id) ??
          UserModel.fromSupabaseUser(user);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('AuthRemoteDatasourceImpl.getCurrentUser: $error');
        debugPrint('$stackTrace');
      }
      return UserModel.fromSupabaseUser(user);
    }
  }

  @override
  Stream<UserModel?> authStateChanges() {
    return _client.auth.onAuthStateChange.asyncMap(
      (supabase.AuthState authState) async {
        final supabase.User? user = authState.session?.user;
        if (user == null) {
          return null;
        }

        try {
          return await _fetchUserProfile(user.id) ??
              UserModel.fromSupabaseUser(user);
        } catch (error, stackTrace) {
          if (kDebugMode) {
            debugPrint('AuthRemoteDatasourceImpl.authStateChanges: $error');
            debugPrint('$stackTrace');
          }
          return UserModel.fromSupabaseUser(user);
        }
      },
    );
  }

  Future<UserModel?> _fetchUserProfile(String userId) async {
    final Map<String, dynamic>? response = await _client
        .from(_usersTable)
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return UserModel.fromJson(response);
  }
}
