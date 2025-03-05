
import 'package:blog_app/utils/entities/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedInState extends AppUserState {
  final User user;
  AppUserLoggedInState({required this.user});
}
