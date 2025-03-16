import 'package:blog_app/utils/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UsecaseInterface<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}

abstract interface class LogoutInterface<Params> {
  Future call(Params params);
}
