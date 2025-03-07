import 'package:blog_app/Features/blogs/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.imageUrl,
    required super.content,
    required super.title,
    required super.topics,
    required super.updatedAt,
  });
}
