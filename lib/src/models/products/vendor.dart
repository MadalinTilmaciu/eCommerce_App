part of '../index.dart';

@freezed
class Vendor with _$Vendor {
  const factory Vendor({
    required String id,
    required String name,
    required String image,
    required String description,
  }) = _Vendor;

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(Map<String, dynamic>.from(json));
}
