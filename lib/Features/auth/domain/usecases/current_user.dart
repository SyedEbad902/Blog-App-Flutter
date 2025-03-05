import 'package:blog_app/utils/entities/user.dart';
import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/utils/error/failure.dart';
import 'package:blog_app/utils/usercase%20interface/usecase_interface.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UsecaseInterface<User, NoParams> {
  final AuthRepositoryInterface authRepositoryInterface;
  CurrentUser({required this. authRepositoryInterface});

  @override
  Future<Either<Failure, User>> call(NoParams params)async  {
return await authRepositoryInterface.getCurrentUser();

  }
}
