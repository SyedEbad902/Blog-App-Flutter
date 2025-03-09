import 'dart:io';

import 'package:blog_app/Features/blogs/data/datasources/blog_data_source.dart';
import 'package:blog_app/Features/blogs/data/models/blog_model.dart';
import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
import 'package:blog_app/Features/blogs/domain/repositories/blog_repository_interface.dart';
import 'package:blog_app/utils/error/exceptions.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepositoryInterface {
  final BlogDataSource blogDataSource;
  BlogRepositoryImpl({required this.blogDataSource});
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: Uuid().v1(),
        posterId: posterId,
        imageUrl: '',
        content: content,
        title: title,
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final String imageUrl = await blogDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );
      print("this is image url $imageUrl");

     final BlogModel newBlog= blogModel.copyWith(imageUrl: imageUrl);
      
      final uploadedBlog = blogModel;
      await blogDataSource.uploadBlog(blog: newBlog);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
