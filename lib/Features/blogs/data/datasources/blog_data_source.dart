import 'dart:io';

import 'package:blog_app/Features/blogs/data/models/blog_model.dart';
import 'package:blog_app/utils/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogDataSource {
  Future<BlogModel> uploadBlog({required BlogModel blog});

  Future<List<BlogModel>> fetchBlogs();
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
}

final class BlogDataSourceImpl implements BlogDataSource {
  final SupabaseClient supabaseClient;

  BlogDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<BlogModel>> fetchBlogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*,profiles (name)');

      final List<BlogModel> allBlogs = [];
      for (var e in blogs) {
        allBlogs.add(BlogModel.fromJson(e).copyWith(posterName: e['profiles']['name']));
      }
      return allBlogs;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
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
      final publicUrl = supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blog.id);
      return publicUrl;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
