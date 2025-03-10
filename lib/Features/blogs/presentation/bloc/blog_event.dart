import 'dart:io';

import 'package:flutter/material.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  BlogUploadEvent({
    required this.title,
    required this.content,
    required this.posterId,
    required this.image,
    required this.topics,
  });
}

final class fetchBlogEvent extends BlogEvent {}
