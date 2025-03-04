import 'package:blog_app/Features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/Features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/Features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/Features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/Features/auth/domain/usecases/user_signup.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/secrets/secrets.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: Secrets.SUPABASE_URL,
    anonKey: Secrets.SUPABASE_ANON_KEY,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  _initAuth();
}

_initAuth() {
  serviceLocator.registerFactory<AuthSupabaseDatasource>(
    () => AuthSupabaseDataSourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepositoryInterface>(
    () => AuthRepositoryImpl(authSupabaseDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignup(authRepoInterface: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignin(authRepositoryInterface: serviceLocator()),
  );
  serviceLocator.registerFactory(() =>
    CurrentUser(authRepositoryInterface: serviceLocator()));
  
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
      userSignin: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
}
