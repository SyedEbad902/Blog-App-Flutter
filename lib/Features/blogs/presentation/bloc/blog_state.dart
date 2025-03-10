import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
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

final class BlogFetchSuccessState extends BlogState {
  final List<Blog> blogs;

  BlogFetchSuccessState({required this.blogs});
}
