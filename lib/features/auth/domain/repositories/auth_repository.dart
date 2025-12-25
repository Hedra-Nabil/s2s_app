import 'package:s2s_app/core/utils/response.dart';
import 'package:s2s_app/features/auth/data/models/auth_request_model.dart';
import 'package:s2s_app/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Response<UserModel>> login(LoginRequestModel request);
  Future<Response<UserModel>> signup(SignupRequestModel request);
  Future<Response<void>> logout();
  Future<UserModel?> getCurrentUser();
  Future<bool> isLoggedIn();
}

