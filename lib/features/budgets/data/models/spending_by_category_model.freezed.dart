// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spending_by_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpendingByCategoryModel {

@JsonKey(name: 'category_id') String get categoryId;@JsonKey(name: 'category_name') String get categoryName;@JsonKey(name: 'icon_name') String get iconName;@JsonKey(name: 'color_hex') String get colorHex;@JsonKey(fromJson: _totalFromJson) double get total;@JsonKey(fromJson: _countFromJson) int get count;
/// Create a copy of SpendingByCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpendingByCategoryModelCopyWith<SpendingByCategoryModel> get copyWith => _$SpendingByCategoryModelCopyWithImpl<SpendingByCategoryModel>(this as SpendingByCategoryModel, _$identity);

  /// Serializes this SpendingByCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpendingByCategoryModel&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.total, total) || other.total == total)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,iconName,colorHex,total,count);

@override
String toString() {
  return 'SpendingByCategoryModel(categoryId: $categoryId, categoryName: $categoryName, iconName: $iconName, colorHex: $colorHex, total: $total, count: $count)';
}


}

/// @nodoc
abstract mixin class $SpendingByCategoryModelCopyWith<$Res>  {
  factory $SpendingByCategoryModelCopyWith(SpendingByCategoryModel value, $Res Function(SpendingByCategoryModel) _then) = _$SpendingByCategoryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'category_id') String categoryId,@JsonKey(name: 'category_name') String categoryName,@JsonKey(name: 'icon_name') String iconName,@JsonKey(name: 'color_hex') String colorHex,@JsonKey(fromJson: _totalFromJson) double total,@JsonKey(fromJson: _countFromJson) int count
});




}
/// @nodoc
class _$SpendingByCategoryModelCopyWithImpl<$Res>
    implements $SpendingByCategoryModelCopyWith<$Res> {
  _$SpendingByCategoryModelCopyWithImpl(this._self, this._then);

  final SpendingByCategoryModel _self;
  final $Res Function(SpendingByCategoryModel) _then;

/// Create a copy of SpendingByCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? categoryName = null,Object? iconName = null,Object? colorHex = null,Object? total = null,Object? count = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpendingByCategoryModel].
extension SpendingByCategoryModelPatterns on SpendingByCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpendingByCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpendingByCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpendingByCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _SpendingByCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpendingByCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _SpendingByCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'category_name')  String categoryName, @JsonKey(name: 'icon_name')  String iconName, @JsonKey(name: 'color_hex')  String colorHex, @JsonKey(fromJson: _totalFromJson)  double total, @JsonKey(fromJson: _countFromJson)  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpendingByCategoryModel() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.iconName,_that.colorHex,_that.total,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'category_name')  String categoryName, @JsonKey(name: 'icon_name')  String iconName, @JsonKey(name: 'color_hex')  String colorHex, @JsonKey(fromJson: _totalFromJson)  double total, @JsonKey(fromJson: _countFromJson)  int count)  $default,) {final _that = this;
switch (_that) {
case _SpendingByCategoryModel():
return $default(_that.categoryId,_that.categoryName,_that.iconName,_that.colorHex,_that.total,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'category_name')  String categoryName, @JsonKey(name: 'icon_name')  String iconName, @JsonKey(name: 'color_hex')  String colorHex, @JsonKey(fromJson: _totalFromJson)  double total, @JsonKey(fromJson: _countFromJson)  int count)?  $default,) {final _that = this;
switch (_that) {
case _SpendingByCategoryModel() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.iconName,_that.colorHex,_that.total,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpendingByCategoryModel extends SpendingByCategoryModel {
  const _SpendingByCategoryModel({@JsonKey(name: 'category_id') required this.categoryId, @JsonKey(name: 'category_name') required this.categoryName, @JsonKey(name: 'icon_name') required this.iconName, @JsonKey(name: 'color_hex') required this.colorHex, @JsonKey(fromJson: _totalFromJson) required this.total, @JsonKey(fromJson: _countFromJson) required this.count}): super._();
  factory _SpendingByCategoryModel.fromJson(Map<String, dynamic> json) => _$SpendingByCategoryModelFromJson(json);

@override@JsonKey(name: 'category_id') final  String categoryId;
@override@JsonKey(name: 'category_name') final  String categoryName;
@override@JsonKey(name: 'icon_name') final  String iconName;
@override@JsonKey(name: 'color_hex') final  String colorHex;
@override@JsonKey(fromJson: _totalFromJson) final  double total;
@override@JsonKey(fromJson: _countFromJson) final  int count;

/// Create a copy of SpendingByCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpendingByCategoryModelCopyWith<_SpendingByCategoryModel> get copyWith => __$SpendingByCategoryModelCopyWithImpl<_SpendingByCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpendingByCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpendingByCategoryModel&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.total, total) || other.total == total)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,iconName,colorHex,total,count);

@override
String toString() {
  return 'SpendingByCategoryModel(categoryId: $categoryId, categoryName: $categoryName, iconName: $iconName, colorHex: $colorHex, total: $total, count: $count)';
}


}

/// @nodoc
abstract mixin class _$SpendingByCategoryModelCopyWith<$Res> implements $SpendingByCategoryModelCopyWith<$Res> {
  factory _$SpendingByCategoryModelCopyWith(_SpendingByCategoryModel value, $Res Function(_SpendingByCategoryModel) _then) = __$SpendingByCategoryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'category_id') String categoryId,@JsonKey(name: 'category_name') String categoryName,@JsonKey(name: 'icon_name') String iconName,@JsonKey(name: 'color_hex') String colorHex,@JsonKey(fromJson: _totalFromJson) double total,@JsonKey(fromJson: _countFromJson) int count
});




}
/// @nodoc
class __$SpendingByCategoryModelCopyWithImpl<$Res>
    implements _$SpendingByCategoryModelCopyWith<$Res> {
  __$SpendingByCategoryModelCopyWithImpl(this._self, this._then);

  final _SpendingByCategoryModel _self;
  final $Res Function(_SpendingByCategoryModel) _then;

/// Create a copy of SpendingByCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? categoryName = null,Object? iconName = null,Object? colorHex = null,Object? total = null,Object? count = null,}) {
  return _then(_SpendingByCategoryModel(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,iconName: null == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
