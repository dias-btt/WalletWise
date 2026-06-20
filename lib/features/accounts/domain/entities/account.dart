import 'package:equatable/equatable.dart';

enum AccountType {
  checking,
  savings,
  cash,
  investment,
}

extension AccountTypeX on AccountType {
  String get dbValue => switch (this) {
        AccountType.checking => 'checking',
        AccountType.savings => 'savings',
        AccountType.cash => 'cash',
        AccountType.investment => 'investment',
      };

  String get label => switch (this) {
        AccountType.checking => 'Checking',
        AccountType.savings => 'Savings',
        AccountType.cash => 'Cash',
        AccountType.investment => 'Investment',
      };

  static AccountType fromDbValue(String value) => switch (value) {
        'checking' => AccountType.checking,
        'savings' => AccountType.savings,
        'cash' => AccountType.cash,
        'investment' => AccountType.investment,
        _ => AccountType.checking,
      };
}

class Account extends Equatable {
  const Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.balance,
    required this.currencyCode,
    required this.colorHex,
    required this.iconName,
    required this.isPrimary,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String name;
  final AccountType type;
  final double balance;
  final String currencyCode;
  final String colorHex;
  final String iconName;
  final bool isPrimary;
  final DateTime createdAt;

  @override
  List<Object?> get props => <Object?>[
        id,
        userId,
        name,
        type,
        balance,
        currencyCode,
        colorHex,
        iconName,
        isPrimary,
        createdAt,
      ];
}
