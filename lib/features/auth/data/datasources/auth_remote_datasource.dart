import 'package:dio/dio.dart' hide Response;
import 'package:s2s_app/core/utils/constants.dart';
import 'package:s2s_app/core/utils/response.dart';
import 'package:s2s_app/features/auth/data/models/auth_request_model.dart';
import 'package:s2s_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Response<UserModel>> login(LoginRequestModel request);
  Future<Response<UserModel>> signup(SignupRequestModel request);
  Future<Response<void>> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<Response<UserModel>> login(LoginRequestModel request) async {
    try {
      final response = await dio.post(
        '${AppConstants.baseUrl}/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        // final token = response.data['token'] as String;
        return Response.success(user, message: 'Login successful');
      } else {
        return Response.error('Login failed', statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      return Response.error(
        e.response?.data['message'] ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return Response.error('Unexpected error occurred');
    }
  }

  @override
  Future<Response<UserModel>> signup(SignupRequestModel request) async {
    try {
      final response = await dio.post(
        '${AppConstants.baseUrl}/auth/signup',
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        final user = UserModel.fromJson(response.data['user']);
        // final token = response.data['token'] as String;
        return Response.success(user, message: 'Signup successful');
      } else {
        return Response.error('Signup failed', statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      return Response.error(
        e.response?.data['message'] ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return Response.error('Unexpected error occurred');
    }
  }

  @override
  Future<Response<void>> logout() async {
    try {
      await dio.post('${AppConstants.baseUrl}/auth/logout');
      return Response.success(null, message: 'Logout successful');
    } on DioException catch (e) {
      return Response.error(
        e.response?.data['message'] ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return Response.error('Unexpected error occurred');
    }
  }
}

