import 'package:blog_app/Features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/user_signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  AuthBloc({required UserSignup userSignup, required UserSignin userSignin})
    : _userSignup = userSignup,
      _userSignin = userSignin,
      super(AuthInitial()) {
    on<AuthSignupEvent>((event, emit) async {
      emit(AuthLoadingState());
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

    on<AuthSigninEvent>((event, emit) async{
      emit(AuthLoadingState());
      final res =await  _userSignin(
        LoginParams(email: event.email, password: event.password),
      );
      res.fold(
        (failure) {
          emit(AuthFailureState(message: failure.message));
        },
        (success) {
          emit(AuthSuccessState(user: success));
        },
      );
    });
  }
}
