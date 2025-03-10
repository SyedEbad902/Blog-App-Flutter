import 'dart:io';

import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepositoryInterface {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> fetchBlogs();
}
