import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallet_wise/core/router/app_routes.dart';
import 'package:wallet_wise/core/theme/app_colors.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';
import 'package:wallet_wise/features/budgets/domain/entities/budget_ring_summary.dart';
import 'package:wallet_wise/features/dashboard/presentation/widgets/account_card.dart';
import 'package:wallet_wise/features/dashboard/presentation/widgets/budget_mini_ring.dart';
import 'package:wallet_wise/features/dashboard/presentation/widgets/total_balance_card.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/presentation/widgets/transaction_list_tile.dart';

class DashboardLoadingView extends StatelessWidget {
  const DashboardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(
          child: TotalBalanceCard(
            totalBalance: 0,
            currencyCode: 'USD',
            isLoading: true,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: AppColors.borderLight,
                  highlightColor: AppColors.surfaceLight,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: const _SectionHeader(title: 'Budgets', onSeeAll: null),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: AppColors.borderLight,
                  highlightColor: AppColors.surfaceLight,
                  child: Container(
                    width: 72,
                    height: 72,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: _SectionHeader(title: 'Recent Transactions', onSeeAll: null),
        ),
        SliverList.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
              baseColor: AppColors.borderLight,
              highlightColor: AppColors.surfaceLight,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.borderLight,
                ),
                title: Container(
                  height: 14,
                  color: AppColors.borderLight,
                ),
                subtitle: Container(
                  height: 12,
                  width: 80,
                  color: AppColors.borderLight,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class DashboardLoadedView extends StatelessWidget {
  const DashboardLoadedView({
    required this.totalBalance,
    required this.currencyCode,
    required this.accounts,
    required this.budgetRings,
    required this.recentTransactions,
    required this.userId,
    required this.onAddAccount,
    required this.onRefresh,
    super.key,
  });

  final double totalBalance;
  final String currencyCode;
  final List<Account> accounts;
  final List<BudgetRingSummary> budgetRings;
  final List<Transaction> recentTransactions;
  final String userId;
  final VoidCallback onAddAccount;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TotalBalanceCard(
              totalBalance: totalBalance,
              currencyCode: currencyCode,
              isLoading: false,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                itemCount: accounts.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == accounts.length) {
                    return AddAccountCard(onTap: onAddAccount);
                  }
                  return AccountCard(account: accounts[index]);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _SectionHeader(
              title: 'Budgets',
              onSeeAll: () => context.push(AppRoutes.budgets),
            ),
          ),
          SliverToBoxAdapter(
            child: budgetRings.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      'No active budgets',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                    ),
                  )
                : SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: budgetRings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: BudgetMiniRing(
                            summary: budgetRings[index],
                            onTap: () => context.push(AppRoutes.budgets),
                          ),
                        );
                      },
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: _SectionHeader(
              title: 'Recent Transactions',
              onSeeAll: () => context.go(AppRoutes.transactions),
            ),
          ),
          recentTransactions.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No recent transactions',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                    ),
                  ),
                )
              : SliverList.builder(
                  itemCount: recentTransactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Transaction transaction = recentTransactions[index];
                    return TransactionListTile(
                      transaction: transaction,
                      onTap: () {},
                    );
                  },
                ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.onSeeAll,
  });

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: const Text('See all'),
            ),
        ],
      ),
    );
  }
}
