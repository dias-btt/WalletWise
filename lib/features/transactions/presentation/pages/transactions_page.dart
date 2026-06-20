import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_event.dart';
import 'package:wallet_wise/features/transactions/presentation/bloc/transaction_state.dart';
import 'package:wallet_wise/features/transactions/presentation/sheets/transaction_detail_sheet.dart';
import 'package:wallet_wise/features/transactions/presentation/utils/transaction_date_grouper.dart';
import 'package:wallet_wise/features/transactions/presentation/widgets/transaction_list_tile.dart';
import 'package:wallet_wise/features/transactions/presentation/sheets/add_transaction_sheet.dart';
import 'package:wallet_wise/shared/widgets/empty_state_view.dart';
import 'package:wallet_wise/shared/widgets/error_view.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({
    this.accountId = '',
    super.key,
  });

  final String accountId;

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TextEditingController _searchController = TextEditingController();
  Transaction? _pendingDelete;

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(LoadTransactions(widget.accountId));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddSheet(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (BuildContext context, TransactionState state) {
          if (state is TransactionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (BuildContext context, TransactionState state) {
          if (state is TransactionLoading || state is TransactionInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionLoaded) {
            return _buildLoaded(context, state);
          }

          if (state is TransactionError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<TransactionBloc>().add(
                    LoadTransactions(widget.accountId),
                  ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, TransactionLoaded state) {
    if (state.transactions.isEmpty) {
      return CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(context, state),
          SliverFillRemaining(
            child: EmptyStateView(
              title: 'No transactions yet',
              message: 'Add your first transaction to start tracking.',
              actionLabel: 'Add transaction',
              onAction: () => _openAddSheet(context),
            ),
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionBloc>().add(LoadTransactions(widget.accountId));
        await context.read<TransactionBloc>().stream.firstWhere(
              (TransactionState item) =>
                  item is TransactionLoaded || item is TransactionError,
            );
      },
      child: CustomScrollView(
        slivers: <Widget>[
          _buildAppBar(context, state),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == state.listItems.length) {
                  if (state.isLoadingMore) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state.hasMore) {
                    context
                        .read<TransactionBloc>()
                        .add(const LoadMoreTransactions());
                  }
                  return const SizedBox(height: 80);
                }

                final TransactionListItem item = state.listItems[index];

                if (item.isHeader) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      item.headerLabel!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  );
                }

                final Transaction transaction = item.transaction!;

                return Dismissible(
                  key: ValueKey<String>(transaction.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Theme.of(context).colorScheme.error,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    _pendingDelete = transaction;
                    context.read<TransactionBloc>().add(
                          DeleteTransactionEvent(transaction.id),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Transaction deleted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            if (_pendingDelete != null) {
                              context.read<TransactionBloc>().add(
                                    RestoreTransactionEvent(_pendingDelete!),
                                  );
                              _pendingDelete = null;
                            }
                          },
                        ),
                      ),
                    );
                  },
                  child: TransactionListTile(
                    transaction: transaction,
                    onTap: () => _openDetailSheet(context, transaction),
                  ),
                );
              },
              childCount: state.listItems.length + 1,
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context, TransactionLoaded state) {
    return SliverAppBar(
      floating: true,
      snap: true,
      title: const Text('Transactions'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search transactions',
                    prefixIcon: const Icon(Icons.search),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onSubmitted: (String value) {
                    context.read<TransactionBloc>().add(
                          FilterChanged(
                            state.filter.copyWith(searchQuery: value),
                          ),
                        );
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _openFilterSheet(context, state),
                icon: const Icon(Icons.filter_list),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openAddSheet(BuildContext context) {
    final TransactionBloc bloc = context.read<TransactionBloc>();
    final TransactionLoaded? loaded = bloc.state as TransactionLoaded?;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext sheetContext) {
        return BlocProvider<TransactionBloc>.value(
          value: bloc,
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.92,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (BuildContext context, ScrollController scrollController) {
              return AddTransactionSheet(
                scrollController: scrollController,
                accountId: loaded?.accountId.isNotEmpty == true
                    ? loaded!.accountId
                    : widget.accountId,
                categories: loaded?.categories ?? const <Category>[],
                currencyCode: 'USD',
              );
            },
          ),
        );
      },
    );
  }

  void _openDetailSheet(BuildContext context, Transaction transaction) {
    final TransactionBloc bloc = context.read<TransactionBloc>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext sheetContext) {
        return BlocProvider<TransactionBloc>.value(
          value: bloc,
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return TransactionDetailSheet(
                transaction: transaction,
                scrollController: scrollController,
              );
            },
          ),
        );
      },
    );
  }

  void _openFilterSheet(BuildContext context, TransactionLoaded state) {
    final TransactionBloc bloc = context.read<TransactionBloc>();
    TransactionType? selectedType = state.filter.type;

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext sheetContext) {
        return BlocProvider<TransactionBloc>.value(
          value: bloc,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Filter',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<TransactionType?>(
                      segments: const <ButtonSegment<TransactionType?>>[
                        ButtonSegment<TransactionType?>(
                          value: null,
                          label: Text('All'),
                        ),
                        ButtonSegment<TransactionType?>(
                          value: TransactionType.income,
                          label: Text('Income'),
                        ),
                        ButtonSegment<TransactionType?>(
                          value: TransactionType.expense,
                          label: Text('Expense'),
                        ),
                      ],
                      selected: <TransactionType?>{selectedType},
                      onSelectionChanged: (Set<TransactionType?> value) {
                        setModalState(() {
                          selectedType = value.first;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<TransactionBloc>().add(
                              FilterChanged(
                                state.filter.copyWith(
                                  type: selectedType,
                                  clearType: selectedType == null,
                                ),
                              ),
                            );
                      },
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
