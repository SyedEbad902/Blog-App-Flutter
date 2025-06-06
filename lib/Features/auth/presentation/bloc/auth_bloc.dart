import 'package:blog_app/Features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/Features/auth/domain/usecases/logout.dart';
import 'package:blog_app/Features/auth/domain/usecases/user_signin.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_event.dart';
import 'package:blog_app/Features/auth/presentation/bloc/auth_state.dart';
import 'package:blog_app/utils/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/utils/usecase%20interface/usecase_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/user_signup.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  final Logout _logout;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignup userSignup,
    required UserSignin userSignin,
    required CurrentUser currentUser,
    required Logout logout,

    required AppUserCubit appUserCubit,
  }) : _userSignup = userSignup,
       _userSignin = userSignin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       _logout = logout,
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
          // emit(AuthSuccessState(user: success));
          _appUserCubit.updateUser(success);
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
          // emit(AuthSuccessState(user: success));
          _appUserCubit.updateUser(success);
        },
      );
    });

    on<CurrentUserEvent>((event, emit) async {
      emit(AuthLoadingState());

      final res = await _currentUser(NoParams());

      res.fold(
        (failure) {
          emit(AuthFailureState(message: failure.message));
        },
        (success) {
          // emit(AuthSuccessState(user: success));
          _appUserCubit.updateUser(success);
        },
      );
    });

    on<LogoutEvent>((event, emit) async {
      try {
        final res = await _logout.call(NoParams());
        emit(AuthSuccess());
      } catch (e) {
        print(e.toString());
        emit(AuthFailureState(message: e.toString()));
      }
    });
  }
}
