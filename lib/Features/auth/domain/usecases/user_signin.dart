import 'package:blog_app/utils/entities/user.dart';
import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:blog_app/utils/usercase%20interface/usecase_interface.dart';
import 'package:fpdart/fpdart.dart';

class UserSignin implements UsecaseInterface<User, LoginParams> {
  final AuthRepositoryInterface authRepositoryInterface;

  UserSignin({required this.authRepositoryInterface,});

  @override
  Future<Either<Failure, User>> call(LoginParams params) async{
  return await  authRepositoryInterface.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
