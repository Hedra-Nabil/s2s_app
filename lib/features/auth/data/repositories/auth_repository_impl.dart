import 'package:s2s_app/core/utils/response.dart';
import 'package:s2s_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:s2s_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:s2s_app/features/auth/data/models/auth_request_model.dart';
import 'package:s2s_app/features/auth/data/models/user_model.dart';
import 'package:s2s_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Response<UserModel>> login(LoginRequestModel request) async {
    final response = await remoteDataSource.login(request);
    
    if (response.success && response.data != null) {
      // Save token and user locally
      // await localDataSource.saveToken(token);
      await localDataSource.saveUser(response.data!);
    }
    
    return response;
  }

  @override
  Future<Response<UserModel>> signup(SignupRequestModel request) async {
    final response = await remoteDataSource.signup(request);
    
    if (response.success && response.data != null) {
      // Save token and user locally
      // await localDataSource.saveToken(token);
      await localDataSource.saveUser(response.data!);
    }
    
    return response;
  }

  @override
  Future<Response<void>> logout() async {
    final response = await remoteDataSource.logout();
    
    if (response.success) {
      await localDataSource.clearAll();
    }
    
    return response;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await localDataSource.getToken();
    return token != null;
  }
}

