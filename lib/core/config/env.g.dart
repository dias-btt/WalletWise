// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: .env
final class _Env {
  static const String supabaseUrl = 'https://your-project.supabase.co';

  static const List<int> _enviedkeysupabaseAnonKey = <int>[
    1364028759,
    660357482,
    3932193083,
    3101458509,
    3593791442,
    3315748207,
    142659415,
    3955381033,
    2909228659,
    3876108571,
    3567686892,
    2074279129,
    2100285262,
    132554235,
    1589314388,
    2639786511,
    1654478890,
    1509576154,
    2121312747,
    988793985,
    3588508167,
    4214101100,
  ];

  static const List<int> _envieddatasupabaseAnonKey = <int>[
    1364028718,
    660357381,
    3932193102,
    3101458495,
    3593791487,
    3315748124,
    142659362,
    3955381081,
    2909228562,
    3876108665,
    3567686797,
    2074279082,
    2100285227,
    132554198,
    1589314357,
    2639786593,
    1654478917,
    1509576116,
    2121312710,
    988794090,
    3588508258,
    4214101013,
  ];

  static final String supabaseAnonKey = String.fromCharCodes(
    List<int>.generate(
      _envieddatasupabaseAnonKey.length,
      (int i) => i,
      growable: false,
    ).map(
      (int i) => _envieddatasupabaseAnonKey[i] ^ _enviedkeysupabaseAnonKey[i],
    ),
  );

  static const List<int> _enviedkeysentryDsn = <int>[];

  static const List<int> _envieddatasentryDsn = <int>[];

  static final String sentryDsn = String.fromCharCodes(
    List<int>.generate(
      _envieddatasentryDsn.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddatasentryDsn[i] ^ _enviedkeysentryDsn[i]),
  );

  static const String environment = 'development';
}
