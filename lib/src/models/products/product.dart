part of '../index.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    required String description,
    required String image,
    required double price,
    required String categoryId,
    required String vendorId,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(Map<String, dynamic>.from(json));
}
