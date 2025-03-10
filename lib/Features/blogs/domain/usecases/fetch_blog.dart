import 'package:blog_app/Features/blogs/domain/entities/blog.dart';
import 'package:blog_app/Features/blogs/domain/repositories/blog_repository_interface.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:blog_app/utils/usecase%20interface/usecase_interface.dart';
import 'package:fpdart/fpdart.dart';

class FetchBlogUseCase implements UsecaseInterface<List<Blog>, NoParams> {
  final BlogRepositoryInterface blogRepositoryInterface;

  FetchBlogUseCase({required this.blogRepositoryInterface});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepositoryInterface.fetchBlogs();
  }
}
