import 'package:blog_app/utils/entities/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}
final class AuthSuccess extends AuthState {}

final class AuthSuccessState extends AuthState {
  final User user;
  AuthSuccessState({required this.user});
}

final class AuthFailureState extends AuthState {
  final String message;
  AuthFailureState({required this.message});
}
