import 'package:blog_app/Features/auth/data/datasource/auth_supabase_datasource.dart';
import 'package:blog_app/Features/auth/data/models/user_model.dart';
import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/utils/entities/user.dart';
import 'package:blog_app/utils/error/exceptions.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:blog_app/utils/network/connection_checker.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthSupabaseDatasource authSupabaseDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl({
    required this.connectionChecker,
    required this.authSupabaseDataSource,
  });
  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No internet connection"));
      }
      final user = await authSupabaseDataSource.loginWithEmailPass(
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure("No internet connection"));
      }
      final user = await authSupabaseDataSource.signupWithEmailPassword(
        email: email,
        name: name,
        password: password,
      );

      return Right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authSupabaseDataSource.currentUserSession;
        if (session == null) {
          return left(Failure("User not LoggedIn"));
        }
        return right(
          UserModel(
            id: session.user.id,
            name: '',
            email: session.user.email ?? '',
          ),
        );
      }
      final user = await authSupabaseDataSource.getCurrentUser();

      if (user == null) {
        return left(Failure("User not logged in"));
      }

      return right(user);
    } on ServerException catch (e) {
      return left((Failure(e.message)));
    }
  }
}
