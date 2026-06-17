import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/core/router/app_router.dart';
import 'package:wallet_wise/core/theme/app_theme.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = getIt<AppRouter>();
    final AuthBloc authBloc = getIt<AuthBloc>();

    return BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: MaterialApp.router(
        title: 'WalletWise',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        routerConfig: appRouter.router,
      ),
    );
  }
}
