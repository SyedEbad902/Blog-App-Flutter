import 'package:blog_app/utils/entities/user.dart';
import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:blog_app/utils/usecase%20interface/usecase_interface.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UsecaseInterface<User, UserSignupParams> {
  final AuthRepositoryInterface authRepoInterface;

  UserSignup({required this.authRepoInterface});

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepoInterface.signupWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String email;
  final String name;
  final String password;

  UserSignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
