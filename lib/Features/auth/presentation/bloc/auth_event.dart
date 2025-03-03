import 'package:flutter/material.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignupEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;

  AuthSignupEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}
