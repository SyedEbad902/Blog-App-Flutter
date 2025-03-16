import 'package:blog_app/Features/auth/domain/repository/auth_repository_interface.dart';
import 'package:blog_app/utils/usecase%20interface/usecase_interface.dart';

class Logout implements LogoutInterface<NoParams> {
  final AuthRepositoryInterface authRepositoryInterface;

  Logout({required this.authRepositoryInterface});
  @override
  Future call(NoParams params) async {
    await authRepositoryInterface.logout();
  }
}
