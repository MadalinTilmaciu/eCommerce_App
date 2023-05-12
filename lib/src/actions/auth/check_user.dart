part of '../index.dart';

@freezed
class CheckUser with _$CheckUser {
  const factory CheckUser() = CheckUserStart;

  @Implements<UserAction>()
  const factory CheckUser.successful(AppUser? user) = CheckUserSuccessful;

  const factory CheckUser.error(Object error, StackTrace stackTrace) = CheckUserError;
}
