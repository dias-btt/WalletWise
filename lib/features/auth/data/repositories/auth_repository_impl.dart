import 'package:fpdart/fpdart.dart';
import 'package:wallet_wise/core/errors/exceptions.dart';
import 'package:wallet_wise/core/errors/failures.dart';
import 'package:wallet_wise/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:wallet_wise/features/auth/domain/entities/user.dart';
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDatasource);

  final AuthRemoteDatasource _remoteDatasource;

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final User user = await _remoteDatasource.signInWithPassword(
        email: email,
        password: password,
      );
      return Right<Failure, User>(user);
    } on AuthAppException catch (error) {
      return Left<Failure, User>(AuthFailure(message: error.message));
    } on AppException catch (error) {
      return Left<Failure, User>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, User>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String displayName,
    required String currencyCode,
  }) async {
    try {
      final User user = await _remoteDatasource.signUp(
        email: email,
        password: password,
        displayName: displayName,
        currencyCode: currencyCode,
      );
      return Right<Failure, User>(user);
    } on AuthAppException catch (error) {
      return Left<Failure, User>(AuthFailure(message: error.message));
    } on AppException catch (error) {
      return Left<Failure, User>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, User>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteDatasource.signOut();
      return const Right<Failure, void>(null);
    } on AuthAppException catch (error) {
      return Left<Failure, void>(AuthFailure(message: error.message));
    } on AppException catch (error) {
      return Left<Failure, void>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, void>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final User? user = await _remoteDatasource.getCurrentUser();
      return Right<Failure, User?>(user);
    } on AuthAppException catch (error) {
      return Left<Failure, User?>(AuthFailure(message: error.message));
    } on AppException catch (error) {
      return Left<Failure, User?>(_mapAppException(error));
    } catch (error) {
      return Left<Failure, User?>(
        UnexpectedFailure(message: error.toString()),
      );
    }
  }

  @override
  Stream<User?> authStateChanges() {
    return _remoteDatasource.authStateChanges();
  }

  Failure _mapAppException(AppException exception) {
    return switch (exception) {
      NetworkException() => NetworkFailure(message: exception.message),
      AuthAppException() => AuthFailure(message: exception.message),
      AuthException() => AuthFailure(message: exception.message),
      CacheException() => CacheFailure(message: exception.message),
      UnexpectedException() => UnexpectedFailure(message: exception.message),
      _ => UnexpectedFailure(message: exception.message),
    };
  }
}
