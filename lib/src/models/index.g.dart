// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppState _$$_AppStateFromJson(Map<String, dynamic> json) => _$_AppState(
      auth: json['auth'] == null ? const AuthState() : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
      pendingActions: (json['pendingActions'] as List<dynamic>?)?.map((e) => e as String).toSet() ?? const <String>{},
    );

Map<String, dynamic> _$$_AppStateToJson(_$_AppState instance) => <String, dynamic>{
      'auth': instance.auth,
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
