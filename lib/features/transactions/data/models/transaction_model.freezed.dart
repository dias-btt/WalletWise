// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionModel {

 String get id;@JsonKey(name: 'account_id') String get accountId;@JsonKey(name: 'category_id') String? get categoryId;@JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson) TransactionType get type;@JsonKey(fromJson: _amountFromJson, toJson: _amountToJson) double get amount;@JsonKey(name: 'currency_code') String get currencyCode; String get title; String? get note; DateTime get date;@JsonKey(name: 'is_recurring') bool get isRecurring;@JsonKey(name: 'recurring_rule_id') String? get recurringRuleId;@JsonKey(name: 'goal_id') String? get goalId;@JsonKey(name: 'created_at') DateTime get createdAt; Map<String, dynamic>? get accounts; CategoryModel? get categories;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.date, date) || other.date == date)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurringRuleId, recurringRuleId) || other.recurringRuleId == recurringRuleId)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&(identical(other.categories, categories) || other.categories == categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,categoryId,type,amount,currencyCode,title,note,date,isRecurring,recurringRuleId,goalId,createdAt,const DeepCollectionEquality().hash(accounts),categories);

@override
String toString() {
  return 'TransactionModel(id: $id, accountId: $accountId, categoryId: $categoryId, type: $type, amount: $amount, currencyCode: $currencyCode, title: $title, note: $note, date: $date, isRecurring: $isRecurring, recurringRuleId: $recurringRuleId, goalId: $goalId, createdAt: $createdAt, accounts: $accounts, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'account_id') String accountId,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson) TransactionType type,@JsonKey(fromJson: _amountFromJson, toJson: _amountToJson) double amount,@JsonKey(name: 'currency_code') String currencyCode, String title, String? note, DateTime date,@JsonKey(name: 'is_recurring') bool isRecurring,@JsonKey(name: 'recurring_rule_id') String? recurringRuleId,@JsonKey(name: 'goal_id') String? goalId,@JsonKey(name: 'created_at') DateTime createdAt, Map<String, dynamic>? accounts, CategoryModel? categories
});


$CategoryModelCopyWith<$Res>? get categories;

}
/// @nodoc
class _$TransactionModelCopyWithImpl<$Res>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._self, this._then);

  final TransactionModel _self;
  final $Res Function(TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? categoryId = freezed,Object? type = null,Object? amount = null,Object? currencyCode = null,Object? title = null,Object? note = freezed,Object? date = null,Object? isRecurring = null,Object? recurringRuleId = freezed,Object? goalId = freezed,Object? createdAt = null,Object? accounts = freezed,Object? categories = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as String?,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as CategoryModel?,
  ));
}
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get categories {
    if (_self.categories == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.categories!, (value) {
    return _then(_self.copyWith(categories: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransactionModel].
extension TransactionModelPatterns on TransactionModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _TransactionModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson)  TransactionType type, @JsonKey(fromJson: _amountFromJson, toJson: _amountToJson)  double amount, @JsonKey(name: 'currency_code')  String currencyCode,  String title,  String? note,  DateTime date, @JsonKey(name: 'is_recurring')  bool isRecurring, @JsonKey(name: 'recurring_rule_id')  String? recurringRuleId, @JsonKey(name: 'goal_id')  String? goalId, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic>? accounts,  CategoryModel? categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.accountId,_that.categoryId,_that.type,_that.amount,_that.currencyCode,_that.title,_that.note,_that.date,_that.isRecurring,_that.recurringRuleId,_that.goalId,_that.createdAt,_that.accounts,_that.categories);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson)  TransactionType type, @JsonKey(fromJson: _amountFromJson, toJson: _amountToJson)  double amount, @JsonKey(name: 'currency_code')  String currencyCode,  String title,  String? note,  DateTime date, @JsonKey(name: 'is_recurring')  bool isRecurring, @JsonKey(name: 'recurring_rule_id')  String? recurringRuleId, @JsonKey(name: 'goal_id')  String? goalId, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic>? accounts,  CategoryModel? categories)  $default,) {final _that = this;
switch (_that) {
case _TransactionModel():
return $default(_that.id,_that.accountId,_that.categoryId,_that.type,_that.amount,_that.currencyCode,_that.title,_that.note,_that.date,_that.isRecurring,_that.recurringRuleId,_that.goalId,_that.createdAt,_that.accounts,_that.categories);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson)  TransactionType type, @JsonKey(fromJson: _amountFromJson, toJson: _amountToJson)  double amount, @JsonKey(name: 'currency_code')  String currencyCode,  String title,  String? note,  DateTime date, @JsonKey(name: 'is_recurring')  bool isRecurring, @JsonKey(name: 'recurring_rule_id')  String? recurringRuleId, @JsonKey(name: 'goal_id')  String? goalId, @JsonKey(name: 'created_at')  DateTime createdAt,  Map<String, dynamic>? accounts,  CategoryModel? categories)?  $default,) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.accountId,_that.categoryId,_that.type,_that.amount,_that.currencyCode,_that.title,_that.note,_that.date,_that.isRecurring,_that.recurringRuleId,_that.goalId,_that.createdAt,_that.accounts,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionModel extends TransactionModel {
  const _TransactionModel({required this.id, @JsonKey(name: 'account_id') required this.accountId, @JsonKey(name: 'category_id') this.categoryId, @JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson) required this.type, @JsonKey(fromJson: _amountFromJson, toJson: _amountToJson) required this.amount, @JsonKey(name: 'currency_code') required this.currencyCode, required this.title, this.note, required this.date, @JsonKey(name: 'is_recurring') required this.isRecurring, @JsonKey(name: 'recurring_rule_id') this.recurringRuleId, @JsonKey(name: 'goal_id') this.goalId, @JsonKey(name: 'created_at') required this.createdAt, final  Map<String, dynamic>? accounts, this.categories}): _accounts = accounts,super._();
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'account_id') final  String accountId;
@override@JsonKey(name: 'category_id') final  String? categoryId;
@override@JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson) final  TransactionType type;
@override@JsonKey(fromJson: _amountFromJson, toJson: _amountToJson) final  double amount;
@override@JsonKey(name: 'currency_code') final  String currencyCode;
@override final  String title;
@override final  String? note;
@override final  DateTime date;
@override@JsonKey(name: 'is_recurring') final  bool isRecurring;
@override@JsonKey(name: 'recurring_rule_id') final  String? recurringRuleId;
@override@JsonKey(name: 'goal_id') final  String? goalId;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
 final  Map<String, dynamic>? _accounts;
@override Map<String, dynamic>? get accounts {
  final value = _accounts;
  if (value == null) return null;
  if (_accounts is EqualUnmodifiableMapView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  CategoryModel? categories;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionModelCopyWith<_TransactionModel> get copyWith => __$TransactionModelCopyWithImpl<_TransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.date, date) || other.date == date)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.recurringRuleId, recurringRuleId) || other.recurringRuleId == recurringRuleId)&&(identical(other.goalId, goalId) || other.goalId == goalId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&(identical(other.categories, categories) || other.categories == categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,categoryId,type,amount,currencyCode,title,note,date,isRecurring,recurringRuleId,goalId,createdAt,const DeepCollectionEquality().hash(_accounts),categories);

@override
String toString() {
  return 'TransactionModel(id: $id, accountId: $accountId, categoryId: $categoryId, type: $type, amount: $amount, currencyCode: $currencyCode, title: $title, note: $note, date: $date, isRecurring: $isRecurring, recurringRuleId: $recurringRuleId, goalId: $goalId, createdAt: $createdAt, accounts: $accounts, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'account_id') String accountId,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(fromJson: _transactionTypeFromJson, toJson: _transactionTypeToJson) TransactionType type,@JsonKey(fromJson: _amountFromJson, toJson: _amountToJson) double amount,@JsonKey(name: 'currency_code') String currencyCode, String title, String? note, DateTime date,@JsonKey(name: 'is_recurring') bool isRecurring,@JsonKey(name: 'recurring_rule_id') String? recurringRuleId,@JsonKey(name: 'goal_id') String? goalId,@JsonKey(name: 'created_at') DateTime createdAt, Map<String, dynamic>? accounts, CategoryModel? categories
});


@override $CategoryModelCopyWith<$Res>? get categories;

}
/// @nodoc
class __$TransactionModelCopyWithImpl<$Res>
    implements _$TransactionModelCopyWith<$Res> {
  __$TransactionModelCopyWithImpl(this._self, this._then);

  final _TransactionModel _self;
  final $Res Function(_TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? categoryId = freezed,Object? type = null,Object? amount = null,Object? currencyCode = null,Object? title = null,Object? note = freezed,Object? date = null,Object? isRecurring = null,Object? recurringRuleId = freezed,Object? goalId = freezed,Object? createdAt = null,Object? accounts = freezed,Object? categories = freezed,}) {
  return _then(_TransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as String?,goalId: freezed == goalId ? _self.goalId : goalId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,accounts: freezed == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as CategoryModel?,
  ));
}

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get categories {
    if (_self.categories == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.categories!, (value) {
    return _then(_self.copyWith(categories: value));
  });
}
}

// dart format on
