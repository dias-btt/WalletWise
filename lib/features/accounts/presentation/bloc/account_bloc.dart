import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_wise/features/accounts/domain/entities/account.dart';
import 'package:wallet_wise/features/accounts/domain/repositories/account_repository.dart';
import 'package:wallet_wise/features/accounts/presentation/bloc/account_event.dart';
import 'package:wallet_wise/features/accounts/presentation/bloc/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required AccountRepository accountRepository,
  })  : _accountRepository = accountRepository,
        super(const AccountInitial()) {
    on<LoadAccounts>(_onLoadAccounts);
    on<CreateAccount>(_onCreateAccount);
  }

  final AccountRepository _accountRepository;

  Future<void> _onLoadAccounts(
    LoadAccounts event,
    Emitter<AccountState> emit,
  ) async {
    emit(const AccountLoading());

    final accountsResult = await _accountRepository.getAccounts(event.userId);
    final balanceResult =
        await _accountRepository.getTotalBalance(event.userId);

    accountsResult.fold(
      (failure) => emit(AccountError(failure.message)),
      (List<Account> accounts) {
        balanceResult.fold(
          (_) => emit(
            AccountLoaded(
              accounts: accounts,
              totalBalance: accounts.fold<double>(
                0,
                (double sum, Account account) => sum + account.balance,
              ),
            ),
          ),
          (double totalBalance) => emit(
            AccountLoaded(
              accounts: accounts,
              totalBalance: totalBalance,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onCreateAccount(
    CreateAccount event,
    Emitter<AccountState> emit,
  ) async {
    final Account account = event.account;
    final result = await _accountRepository.createAccount(account);

    result.fold(
      (failure) => emit(AccountError(failure.message)),
      (Account created) {
        final AccountState current = state;
        if (current is AccountLoaded) {
          final List<Account> updated = <Account>[
            ...current.accounts,
            created,
          ];
          emit(
            AccountLoaded(
              accounts: updated,
              totalBalance: current.totalBalance + created.balance,
            ),
          );
        } else {
          add(LoadAccounts(account.userId));
        }
      },
    );
  }
}
