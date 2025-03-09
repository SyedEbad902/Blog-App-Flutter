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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'image_url': imageUrl,
      'content': content,
      'title': title,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      imageUrl: map['image_url'] as String,
      content: map['content'] as String,
      title: map['title'] as String,
      topics:
          (map['topics'] as List<dynamic>).map((e) => e.toString()).toList(),
      //  List<String>.from((map['topics'] as List<String>)),
      updatedAt:
          map['updated_at'] == null
              ? DateTime.now()
              : DateTime.parse(map['updated_at']),
    );
  }

  //  BlogModel copyWith({
  //   String? id,
  //   String? posterId,
  //   String? imageUrl,
  //   String? content,
  //   String? title,
  //   List<String>? topics,
  //   DateTime? updatedAt,
  // }) {
  //   return BlogModel(
  //     id: id ?? this.id,
  //     posterId: posterId ?? this.posterId,
  //     imageUrl: imageUrl ?? this.imageUrl,
  //     content: content ?? this.content,
  //     title: title ?? this.title,
  //     topics: topics ?? this.topics,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //   );
  // }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? imageUrl,
    String? content,
    String? title,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      imageUrl: imageUrl ?? this.imageUrl,
      content: content ?? this.content,
      title: title ?? this.title,
      topics: topics ?? List<String>.from(this.topics),
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  // String toJson() => json.encode(toJson());

  // factory BlogModel.fromJson(String source) => BlogModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
