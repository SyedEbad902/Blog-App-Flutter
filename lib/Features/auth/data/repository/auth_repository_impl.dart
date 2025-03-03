import 'package:blog_app/Features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/Features/auth/data/models/user_model.dart';
import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/utils/error/exceptions.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthSupabaseDatasource authSupabaseDataSource;

  AuthRepositoryImpl({required this.authSupabaseDataSource});
  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user= await authSupabaseDataSource
          .signupWithEmailPassword(
            email: email,
            name: name,
            password: password,
          );

      return Right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
