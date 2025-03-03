import 'package:blog_app/Features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../utils/error/exceptions.dart';

abstract interface class AuthSupabaseDatasource {
  Future<UserModel> signupWithEmailPassword({
    required String email,
    required String name,
    required String password,
  });

  Future<UserModel> loginWithEmailPass({
    required String email,
    required String password,
  });
}

class AuthSupabaseDataSourceImpl implements AuthSupabaseDatasource {
  final SupabaseClient supabaseClient;
  AuthSupabaseDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> loginWithEmailPass({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPass
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signupWithEmailPassword({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException(message: 'User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
