import 'package:equatable/equatable.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class LoadAccounts extends AccountEvent {
  const LoadAccounts(this.userId);

  final String userId;

  @override
  List<Object?> get props => <Object?>[userId];
}

final class CreateAccount extends AccountEvent {
  const CreateAccount(this.account);

  final Account account;

  @override
  List<Object?> get props => <Object?>[account];
}
