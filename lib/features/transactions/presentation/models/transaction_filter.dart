import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/transactions/domain/entities/transaction.dart';

class TransactionFilter extends Equatable {
  const TransactionFilter({
    this.type,
    this.searchQuery = '',
    this.categoryId,
    this.startDate,
    this.endDate,
  });

  final TransactionType? type;
  final String searchQuery;
  final String? categoryId;
  final DateTime? startDate;
  final DateTime? endDate;

  TransactionFilter copyWith({
    TransactionType? type,
    String? searchQuery,
    String? categoryId,
    DateTime? startDate,
    DateTime? endDate,
    bool clearType = false,
    bool clearCategoryId = false,
    bool clearStartDate = false,
    bool clearEndDate = false,
  }) {
    return TransactionFilter(
      type: clearType ? null : (type ?? this.type),
      searchQuery: searchQuery ?? this.searchQuery,
      categoryId: clearCategoryId ? null : (categoryId ?? this.categoryId),
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        type,
        searchQuery,
        categoryId,
        startDate,
        endDate,
      ];
}
