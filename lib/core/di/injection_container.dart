import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s2s_app/core/services/media_service.dart';
import 'package:s2s_app/core/utils/constants.dart';
import 'package:s2s_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:s2s_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:s2s_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:s2s_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:s2s_app/features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
    ),
  );
  sl.registerLazySingleton(() => dio);

  // Services
  sl.registerLazySingleton(() => MediaService());

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Cubits
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
}
