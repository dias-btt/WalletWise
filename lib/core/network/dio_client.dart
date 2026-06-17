import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wallet_wise/core/config/env.dart';
import 'package:wallet_wise/core/network/interceptors/auth_interceptor.dart';
import 'package:wallet_wise/core/network/interceptors/logging_interceptor.dart';

@lazySingleton
class DioClient {
  DioClient(this._dio);

  final Dio _dio;

  Dio get dio => _dio;

  @factoryMethod
  factory DioClient.create(SupabaseClient supabaseClient) {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: Env.supabaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(supabaseClient),
      LoggingInterceptor(),
    ]);

    return DioClient(dio);
  }
}
