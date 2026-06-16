import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/app.dart';
import 'package:wallet_wise/core/config/env.dart';
import 'package:wallet_wise/core/database/collections/app_metadata.dart';
import 'package:wallet_wise/injection_container.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (SentryFlutterOptions options) {
      options.dsn = Env.sentryDsn;
      options.environment = Env.environment;
      options.tracesSampleRate = 1.0;
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Supabase.initialize(
        url: Env.supabaseUrl,
        publishableKey: Env.supabaseAnonKey,
      );

      final Isar isar = await _initializeIsar();
      registerIsarInstance(isar);

      await configureDependencies();

      runApp(
        SentryWidget(
          child: const App(),
        ),
      );
    },
  );
}

Future<Isar> _initializeIsar() async {
  final directory = await getApplicationDocumentsDirectory();
  return Isar.open(
    [AppMetadataSchema],
    directory: directory.path,
    name: 'wallet_wise',
  );
}
