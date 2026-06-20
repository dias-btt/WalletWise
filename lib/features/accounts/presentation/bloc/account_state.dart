import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object?> get props => <Object?>[];
}

final class AccountInitial extends AccountState {
  const AccountInitial();
}

final class AccountLoading extends AccountState {
  const AccountLoading();
}

final class AccountLoaded extends AccountState {
  const AccountLoaded({
    required this.accounts,
    required this.totalBalance,
  });

  final List<Account> accounts;
  final double totalBalance;

  @override
  List<Object?> get props => <Object?>[accounts, totalBalance];
}

final class AccountError extends AccountState {
  const AccountError(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
