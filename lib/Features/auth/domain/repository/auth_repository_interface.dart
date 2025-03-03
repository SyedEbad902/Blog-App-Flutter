import 'package:blog_app/Features/auth/domain/entities/user.dart' show User;
import 'package:blog_app/utils/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepositoryInterface {
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
