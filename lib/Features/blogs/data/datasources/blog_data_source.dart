import 'dart:io';

import 'package:blog_app/Features/blogs/data/models/blog_model.dart';
import 'package:blog_app/utils/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogDataSource {
  Future<BlogModel> uploadBlog({required BlogModel blog});

  Future<BlogModel> fetchBlog();
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
}

final class BlogDataSourceImpl implements BlogDataSource {
  final SupabaseClient supabaseClient;

  BlogDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> fetchBlog() {
    // TODO: implement fetchBlog
    throw UnimplementedError();
  }

  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final uploadedBlog =
          await supabaseClient.from("blogs").insert(blog.toJson()).select();
      return BlogModel.fromJson(uploadedBlog.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
