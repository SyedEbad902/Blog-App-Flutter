import 'dart:io';

import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
import 'package:blog_app/Features/blogs/domain/repositories/blog_repository_interface.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:blog_app/utils/usecase%20interface/usecase_interface.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements UsecaseInterface<Blog, UploadBlogParams> {
  final BlogRepositoryInterface blogRepositoryInterface;

  UploadBlogUseCase({required this.blogRepositoryInterface});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepositoryInterface.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.image,
    required this.topics,
  });
}
