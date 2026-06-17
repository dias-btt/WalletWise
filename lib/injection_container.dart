import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'injection_container.config.dart';

final GetIt getIt = GetIt.instance;

Isar? _isarInstance;

void registerIsarInstance(Isar isar) {
  _isarInstance = isar;
}

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class AppModule {
  @lazySingleton
  SupabaseClient supabaseClient() => Supabase.instance.client;

  @lazySingleton
  Connectivity connectivity() => Connectivity();

  @preResolve
  @singleton
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @singleton
  Isar isar() {
    final Isar? instance = _isarInstance;
    if (instance == null) {
      throw StateError(
        'Isar must be initialized and registered before configureDependencies',
      );
    }
    return instance;
  }
}
