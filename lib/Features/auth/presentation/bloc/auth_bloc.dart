import 'package:blog_app/Features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/user_signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  AuthBloc({required UserSignup userSignup})
    : _userSignup = userSignup,
      super(AuthInitial()) {
    on<AuthSignupEvent>((event, emit) async {
      final res = await _userSignup(
        UserSignupParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      res.fold(
        (failure) {
          emit(AuthFailureState(message: failure.message));
          print(failure.message);
        },
        (success) {
          print("success: $success");
          emit(AuthSuccessState(user: success));
        },
      );
    });
  }
}
