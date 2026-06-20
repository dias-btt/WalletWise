import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_wise/features/transactions/domain/entities/category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

CategoryGroup _groupFromJson(String value) => CategoryGroupX.fromDbValue(value);

String _groupToJson(CategoryGroup group) => group.dbValue;

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    @JsonKey(name: 'user_id') String? userId,
    required String name,
    @JsonKey(name: 'icon_name') required String iconName,
    @JsonKey(name: 'color_hex') required String colorHex,
    @JsonKey(
      name: 'group_name',
      fromJson: _groupFromJson,
      toJson: _groupToJson,
    )
    required CategoryGroup groupName,
    @JsonKey(name: 'is_system') required bool isSystem,
    @JsonKey(name: 'sort_order') required int sortOrder,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Category toEntity() {
    return Category(
      id: id,
      userId: userId,
      name: name,
      iconName: iconName,
      colorHex: colorHex,
      groupName: groupName,
      isSystem: isSystem,
      sortOrder: sortOrder,
    );
  }
}
