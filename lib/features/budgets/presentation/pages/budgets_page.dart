import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wallet_wise/features/auth/presentation/bloc/auth_state.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_with_progress.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_bloc.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_event.dart';
import 'package:wallet_wise/features/budgets/presentation/bloc/budget_state.dart';
import 'package:wallet_wise/features/budgets/presentation/pages/budget_detail_page.dart';
import 'package:wallet_wise/features/budgets/presentation/sheets/add_budget_sheet.dart';
import 'package:wallet_wise/features/budgets/presentation/widgets/budget_progress_card.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/shared/widgets/empty_state_view.dart';
import 'package:wallet_wise/shared/widgets/error_view.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  @override
  void initState() {
    super.initState();
    final AuthState authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      context.read<BudgetBloc>().add(LoadBudgets(authState.user.id));
    }
  }

  Category? _findCategory(List<Category> categories, String categoryId) {
    for (final Category category in categories) {
      if (category.id == categoryId) {
        return category;
      }
    }
    return null;
  }

  Future<void> _openAddSheet(BuildContext context, BudgetLoaded state) async {
    final AuthState authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      return;
    }

    await AddBudgetSheet.show(
      context,
      userId: authState.user.id,
      categories: state.categories,
      currencyCode: authState.user.currencyCode,
    );
  }

  void _openDetail(
    BuildContext context,
    BudgetWithProgress budget,
    Category? category,
    List<Category> categories,
  ) {
    context.push(
      AppRoutes.budgetDetail(budget.id),
      extra: BudgetDetailArgs(
        budget: budget,
        category: category,
        categories: categories,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final BudgetState state = context.read<BudgetBloc>().state;
          if (state is BudgetLoaded) {
            _openAddSheet(context, state);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<BudgetBloc, BudgetState>(
        listener: (BuildContext context, BudgetState state) {
          if (state is BudgetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (BuildContext context, BudgetState state) {
          if (state is BudgetLoading || state is BudgetInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BudgetError) {
            final AuthState authState = context.read<AuthBloc>().state;
            return ErrorView(
              message: state.message,
              onRetry: () {
                if (authState is Authenticated) {
                  context.read<BudgetBloc>().add(LoadBudgets(authState.user.id));
                }
              },
            );
          }

          if (state is BudgetLoaded) {
            if (state.budgetsWithProgress.isEmpty) {
              return EmptyStateView(
                title: 'No budgets yet',
                message: 'Set spending limits by category to stay on track.',
                actionLabel: 'Add budget',
                onAction: () => _openAddSheet(context, state),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                final AuthState authState = context.read<AuthBloc>().state;
                if (authState is Authenticated) {
                  context.read<BudgetBloc>().add(LoadBudgets(authState.user.id));
                  await context.read<BudgetBloc>().stream.firstWhere(
                        (BudgetState s) => s is! BudgetLoading,
                      );
                }
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.budgetsWithProgress.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 12),
                itemBuilder: (BuildContext context, int index) {
                  final BudgetWithProgress budget =
                      state.budgetsWithProgress[index];
                  final Category? category = _findCategory(
                    state.categories,
                    budget.categoryId,
                  );

                  return BudgetProgressCard(
                    budget: budget,
                    category: category,
                    onTap: () => _openDetail(
                      context,
                      budget,
                      category,
                      state.categories,
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
