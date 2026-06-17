// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar_community/isar.dart' as _i214;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:wallet_wise/core/network/dio_client.dart' as _i484;
import 'package:wallet_wise/core/network/network_info.dart' as _i4;
import 'package:wallet_wise/core/router/app_router.dart' as _i558;
import 'package:wallet_wise/features/auth/auth_module.dart' as _i1022;
import 'package:wallet_wise/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i991;
import 'package:wallet_wise/features/auth/domain/repositories/auth_repository.dart'
    as _i666;
import 'package:wallet_wise/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i545;
import 'package:wallet_wise/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i1019;
import 'package:wallet_wise/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i298;
import 'package:wallet_wise/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i963;
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart'
    as _i650;
import 'package:wallet_wise/injection_container.dart' as _i244;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final authModule = _$AuthModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => appModule.prefs(),
      preResolve: true,
    );
    gh.singleton<_i214.Isar>(() => appModule.isar());
    gh.lazySingleton<_i454.SupabaseClient>(() => appModule.supabaseClient());
    gh.lazySingleton<_i895.Connectivity>(() => appModule.connectivity());
    gh.lazySingleton<_i484.DioClient>(
      () => _i484.DioClient.create(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i4.NetworkInfo>(
      () => _i4.NetworkInfo(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i558.AppRouter>(
      () => _i558.AppRouter(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i991.AuthRemoteDatasource>(
      () => authModule.authRemoteDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i666.AuthRepository>(
      () => authModule.authRepository(gh<_i991.AuthRemoteDatasource>()),
    );
    gh.factory<_i1019.SignInUseCase>(
      () => authModule.signInUseCase(gh<_i666.AuthRepository>()),
    );
    gh.factory<_i963.SignUpUseCase>(
      () => authModule.signUpUseCase(gh<_i666.AuthRepository>()),
    );
    gh.factory<_i298.SignOutUseCase>(
      () => authModule.signOutUseCase(gh<_i666.AuthRepository>()),
    );
    gh.factory<_i545.GetCurrentUserUseCase>(
      () => authModule.getCurrentUserUseCase(gh<_i666.AuthRepository>()),
    );
    gh.lazySingleton<_i650.AuthBloc>(
      () => authModule.authBloc(
        gh<_i1019.SignInUseCase>(),
        gh<_i963.SignUpUseCase>(),
        gh<_i298.SignOutUseCase>(),
        gh<_i545.GetCurrentUserUseCase>(),
        gh<_i666.AuthRepository>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i244.AppModule {}

class _$AuthModule extends _i1022.AuthModule {}
