import 'package:shared_preferences/shared_preferences.dart';
import 'package:s2s_app/core/utils/constants.dart';
import 'package:s2s_app/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(AppConstants.tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(AppConstants.tokenKey);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    // In a real app, use jsonEncode from dart:convert
    final userJson = user.toJson();
    await sharedPreferences.setString(AppConstants.userKey, userJson.toString());
  }

  @override
  Future<UserModel?> getUser() async {
    final userString = sharedPreferences.getString(AppConstants.userKey);
    if (userString == null) return null;
    // In a real app, use jsonDecode from dart:convert
    // For now, return null as placeholder
    return null;
  }

  @override
  Future<void> clearAll() async {
    await sharedPreferences.remove(AppConstants.tokenKey);
    await sharedPreferences.remove(AppConstants.userKey);
  }
}

