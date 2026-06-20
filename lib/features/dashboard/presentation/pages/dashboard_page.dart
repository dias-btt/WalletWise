import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/features/accounts/presentation/bloc/account_bloc.dart';
import 'package:wallet_wise/features/accounts/presentation/sheets/add_account_sheet.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:wallet_wise/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:wallet_wise/features/dashboard/presentation/widgets/dashboard_content.dart';
import 'package:wallet_wise/injection_container.dart';
import 'package:wallet_wise/shared/widgets/error_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    final AuthState authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      context
          .read<DashboardBloc>()
          .add(DashboardStarted(authState.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>.value(
      value: getIt<AccountBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: BlocConsumer<DashboardBloc, DashboardState>(
          listener: (BuildContext context, DashboardState state) {
            if (state is DashboardError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (BuildContext context, DashboardState state) {
            if (state is DashboardLoading || state is DashboardInitial) {
              return const DashboardLoadingView();
            }

            if (state is DashboardLoaded) {
              final AuthState authState = context.read<AuthBloc>().state;
              final String userId =
                  authState is Authenticated ? authState.user.id : '';
              final String currencyCode = authState is Authenticated
                  ? authState.user.currencyCode
                  : state.currencyCode;

              return DashboardLoadedView(
                totalBalance: state.totalBalance,
                currencyCode: state.currencyCode,
                accounts: state.accounts,
                budgetRings: state.budgetRings,
                recentTransactions: state.recentTransactions,
                userId: userId,
                onAddAccount: () async {
                  await AddAccountSheet.show(
                    context,
                    userId: userId,
                    defaultCurrencyCode: currencyCode,
                  );
                  if (context.mounted) {
                    context
                        .read<DashboardBloc>()
                        .add(const DashboardRefreshed());
                  }
                },
                onRefresh: () async {
                  context.read<DashboardBloc>().add(const DashboardRefreshed());
                  await context.read<DashboardBloc>().stream.firstWhere(
                        (DashboardState s) => s is! DashboardLoading,
                      );
                },
              );
            }

            if (state is DashboardError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  final AuthState authState = context.read<AuthBloc>().state;
                  if (authState is Authenticated) {
                    context.read<DashboardBloc>().add(
                          DashboardStarted(authState.user.id),
                        );
                  }
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
