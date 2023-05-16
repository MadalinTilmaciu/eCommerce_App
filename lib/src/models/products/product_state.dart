part of '../index.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(<Product>[]) List<Product> products,
    @Default(<Vendor>[]) List<Vendor> vendors,
    @Default(<Category>[]) List<Category> categories,
    String? selectedCategoryId,
  }) = _ProductState;

  factory ProductState.fromJson(Map<String, dynamic> json) => _$ProductStateFromJson(Map<String, dynamic>.from(json));
}
