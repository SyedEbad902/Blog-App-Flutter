import 'package:blog_app/Features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/Features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/Features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/Features/auth/domain/usecases/logout.dart';
import 'package:blog_app/Features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/Features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/Features/blogs/data/datasources/blog_data_source.dart';
import 'package:blog_app/Features/blogs/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/Features/blogs/domain/repositories/blog_repository_interface.dart';
import 'package:blog_app/Features/blogs/domain/usecases/fetch_blog.dart';
import 'package:blog_app/Features/blogs/domain/usecases/upload_blog.dart';
import 'package:blog_app/Features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/secrets/secrets.dart';
import 'package:blog_app/utils/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/utils/network/connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: Secrets.SUPABASE_URL,
    anonKey: Secrets.SUPABASE_ANON_KEY,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  _initAuth();
  _initBlog();
}

_initAuth() {
  serviceLocator.registerFactory<AuthSupabaseDatasource>(
    () => AuthSupabaseDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepositoryInterface>(
    () => AuthRepositoryImpl(authSupabaseDataSource: serviceLocator(), connectionChecker: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignup(authRepoInterface: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignin(authRepositoryInterface: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => CurrentUser(authRepositoryInterface: serviceLocator()),
  );

  //Cubit initialized
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(() => Logout(authRepositoryInterface: serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
      userSignin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(), logout: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => InternetConnection()
  );
   serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );
}

void _initBlog() {
 
 //Data Source
  serviceLocator
    ..registerFactory<BlogDataSource>(
      () => BlogDataSourceImpl(supabaseClient: serviceLocator()),
    )
 //Repository

    ..registerFactory<BlogRepositoryInterface>(
      () => BlogRepositoryImpl(blogDataSource: serviceLocator()),
    )
 //Use Case

    ..registerFactory(
      () => UploadBlogUseCase(blogRepositoryInterface: serviceLocator()),
    )
    ..registerFactory(()=>
    FetchBlogUseCase(blogRepositoryInterface: serviceLocator()))
 //Bloc
    ..registerLazySingleton(
      () => BlogBloc(uploadBlogUseCase: serviceLocator(), fetchBlogUseCase: serviceLocator()),
    )
    
    ;
}
