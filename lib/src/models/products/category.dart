part of '../index.dart';

@freezed
class Category with _$Category implements Comparable<Category> {
  const factory Category({
    required String id,
    required String title,
    required int icon,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(Map<String, dynamic>.from(json));

  @override
  int compareTo(Category other) {
    return title.compareTo(other.title);
  }
}
