// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppState _$$_AppStateFromJson(Map<String, dynamic> json) => _$_AppState(
      auth: json['auth'] == null ? const AuthState() : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
      products: json['products'] == null
          ? const ProductState()
          : ProductState.fromJson(json['products'] as Map<String, dynamic>),
      pendingActions: (json['pendingActions'] as List<dynamic>?)?.map((e) => e as String).toSet() ?? const <String>{},
    );

Map<String, dynamic> _$$_AppStateToJson(_$_AppState instance) => <String, dynamic>{
      'auth': instance.auth,
      'products': instance.products,
      'pendingActions': instance.pendingActions.toList(),
    };

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      profileUrl: json['profileUrl'] as String?,
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'profileUrl': instance.profileUrl,
    };

_$_AuthState _$$_AuthStateFromJson(Map<String, dynamic> json) => _$_AuthState(
      user: json['user'] == null ? null : AppUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AuthStateToJson(_$_AuthState instance) => <String, dynamic>{
      'user': instance.user,
    };

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      categoryId: json['categoryId'] as String,
      vendorId: json['vendorId'] as String,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'vendorId': instance.vendorId,
    };

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as int,
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'icon': instance.icon,
    };

_$_Vendor _$$_VendorFromJson(Map<String, dynamic> json) => _$_Vendor(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$_VendorToJson(_$_Vendor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
    };

_$_ProductState _$$_ProductStateFromJson(Map<String, dynamic> json) => _$_ProductState(
      products:
          (json['products'] as List<dynamic>?)?.map((e) => Product.fromJson(e as Map<String, dynamic>)).toList() ??
              const <Product>[],
      vendors: (json['vendors'] as List<dynamic>?)?.map((e) => Vendor.fromJson(e as Map<String, dynamic>)).toList() ??
          const <Vendor>[],
      categories:
          (json['categories'] as List<dynamic>?)?.map((e) => Category.fromJson(e as Map<String, dynamic>)).toList() ??
              const <Category>[],
      selectedCategoryId: json['selectedCategoryId'] as String?,
    );

Map<String, dynamic> _$$_ProductStateToJson(_$_ProductState instance) => <String, dynamic>{
      'products': instance.products,
      'vendors': instance.vendors,
      'categories': instance.categories,
      'selectedCategoryId': instance.selectedCategoryId,
    };
