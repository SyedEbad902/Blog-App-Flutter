
import 'package:flutter/material.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogFailureState extends BlogState {
  final String error;
  BlogFailureState({required this.error});

}

final class BlogSuccessState extends BlogState {}
