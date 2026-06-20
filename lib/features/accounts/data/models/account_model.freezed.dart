// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get name;@JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson) AccountType get type;@JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson) double get balance;@JsonKey(name: 'currency_code') String get currencyCode;@JsonKey(name: 'color_hex') String get colorHex;@JsonKey(name: 'icon_name') String get iconName;@JsonKey(name: 'is_primary') bool get isPrimary;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,type,balance,currencyCode,colorHex,iconName,isPrimary,createdAt);

@override
String toString() {
  return 'AccountModel(id: $id, userId: $userId, name: $name, type: $type, balance: $balance, currencyCode: $currencyCode, colorHex: $colorHex, iconName: $iconName, isPrimary: $isPrimary, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String name,@JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson) AccountType type,@JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson) double balance,@JsonKey(name: 'currency_code') String currencyCode,@JsonKey(name: 'color_hex') String colorHex,@JsonKey(name: 'icon_name') String iconName,@JsonKey(name: 'is_primary') bool isPrimary,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? type = null,Object? balance = null,Object? currencyCode = null,Object? colorHex = null,Object? iconName = null,Object? isPrimary = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String name, @JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson)  AccountType type, @JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson)  double balance, @JsonKey(name: 'currency_code')  String currencyCode, @JsonKey(name: 'color_hex')  String colorHex, @JsonKey(name: 'icon_name')  String iconName, @JsonKey(name: 'is_primary')  bool isPrimary, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.type,_that.balance,_that.currencyCode,_that.colorHex,_that.iconName,_that.isPrimary,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String name, @JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson)  AccountType type, @JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson)  double balance, @JsonKey(name: 'currency_code')  String currencyCode, @JsonKey(name: 'color_hex')  String colorHex, @JsonKey(name: 'icon_name')  String iconName, @JsonKey(name: 'is_primary')  bool isPrimary, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.id,_that.userId,_that.name,_that.type,_that.balance,_that.currencyCode,_that.colorHex,_that.iconName,_that.isPrimary,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String name, @JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson)  AccountType type, @JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson)  double balance, @JsonKey(name: 'currency_code')  String currencyCode, @JsonKey(name: 'color_hex')  String colorHex, @JsonKey(name: 'icon_name')  String iconName, @JsonKey(name: 'is_primary')  bool isPrimary, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.type,_that.balance,_that.currencyCode,_that.colorHex,_that.iconName,_that.isPrimary,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountModel extends AccountModel {
  const _AccountModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.name, @JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson) required this.type, @JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson) required this.balance, @JsonKey(name: 'currency_code') required this.currencyCode, @JsonKey(name: 'color_hex') required this.colorHex, @JsonKey(name: 'icon_name') required this.iconName, @JsonKey(name: 'is_primary') required this.isPrimary, @JsonKey(name: 'created_at') required this.createdAt}): super._();
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String name;
@override@JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson) final  AccountType type;
@override@JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson) final  double balance;
@override@JsonKey(name: 'currency_code') final  String currencyCode;
@override@JsonKey(name: 'color_hex') final  String colorHex;
@override@JsonKey(name: 'icon_name') final  String iconName;
@override@JsonKey(name: 'is_primary') final  bool isPrimary;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,type,balance,currencyCode,colorHex,iconName,isPrimary,createdAt);

@override
String toString() {
  return 'AccountModel(id: $id, userId: $userId, name: $name, type: $type, balance: $balance, currencyCode: $currencyCode, colorHex: $colorHex, iconName: $iconName, isPrimary: $isPrimary, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String name,@JsonKey(fromJson: _accountTypeFromJson, toJson: _accountTypeToJson) AccountType type,@JsonKey(fromJson: _balanceFromJson, toJson: _balanceToJson) double balance,@JsonKey(name: 'currency_code') String currencyCode,@JsonKey(name: 'color_hex') String colorHex,@JsonKey(name: 'icon_name') String iconName,@JsonKey(name: 'is_primary') bool isPrimary,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? type = null,Object? balance = null,Object? currencyCode = null,Object? colorHex = null,Object? iconName = null,Object? isPrimary = null,Object? createdAt = null,}) {
  return _then(_AccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
