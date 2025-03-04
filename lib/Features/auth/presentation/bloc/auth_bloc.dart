import 'package:blog_app/Features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/Features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_state.dart';
import 'package:blog_app/utils/usercase%20interface/usecase_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/user_signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignup userSignup,
    required UserSignin userSignin,
    required CurrentUser currentUser,
  }) : _userSignup = userSignup,
       _userSignin = userSignin,
       _currentUser = currentUser,
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

    on<AuthSigninEvent>((event, emit) async {
      emit(AuthLoadingState());
      final res = await _userSignin(
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

    on<CurrentUserEvent>((event, emit) async {
      final res = await _currentUser(NoParams());

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
