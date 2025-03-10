import 'package:blog_app/Features/blogs/domain/usecases/fetch_blog.dart';
import 'package:blog_app/Features/blogs/domain/usecases/upload_blog.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_event.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_state.dart';
import 'package:blog_app/utils/usecase%20interface/usecase_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadBlogUseCase;
  final FetchBlogUseCase _fetchBlogUseCase;
  BlogBloc({
    required UploadBlogUseCase uploadBlogUseCase,
    required FetchBlogUseCase fetchBlogUseCase,
  }) : _fetchBlogUseCase = fetchBlogUseCase,
       _uploadBlogUseCase = uploadBlogUseCase,
       super(BlogInitial()) {
    // on<BlogEvent>((event, emit) {
    //   emit(BlogLoadingState());
    // });

    on<BlogUploadEvent>((event, emit) async {
      emit(BlogLoadingState());
      final result = await _uploadBlogUseCase(
        UploadBlogParams(
          title: event.title,
          content: event.content,
          posterId: event.posterId,
          image: event.image,
          topics: event.topics,
        ),
      );
      result.fold(
        (l) {
          print('failure');

          emit(BlogFailureState(error: l.message));
        },
        (r) {
          print('success');
          emit(BlogSuccessState());
        },
      );
    });

    on<fetchBlogEvent>((event, emit) async {
      emit(BlogLoadingState());

      final result = await _fetchBlogUseCase(NoParams());

      result.fold(
        (l) {
          emit(BlogFailureState(error: l.message));
        },
        (r) {
          emit(BlogFetchSuccessState(blogs: r));
        },
      );
    });
  }
}
