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
import 'package:wallet_wise/injection_container.dart' as _i244;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
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
    return this;
  }
}

class _$AppModule extends _i244.AppModule {}
