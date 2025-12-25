import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:s2s_app/features/auth/data/models/auth_request_model.dart';
import 'package:s2s_app/features/auth/data/models/user_model.dart';
import 'package:s2s_app/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    
    final request = LoginRequestModel(email: email, password: password);
    final response = await authRepository.login(request);
    
    if (response.success && response.data != null) {
      emit(AuthAuthenticated(user: response.data!));
    } else {
      emit(AuthError(message: response.message ?? 'Login failed'));
    }
  }

  Future<void> signup(String name, String email, String password) async {
    emit(AuthLoading());
    
    final request = SignupRequestModel(name: name, email: email, password: password);
    final response = await authRepository.signup(request);
    
    if (response.success && response.data != null) {
      emit(AuthAuthenticated(user: response.data!));
    } else {
      emit(AuthError(message: response.message ?? 'Signup failed'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    
    final response = await authRepository.logout();
    
    if (response.success) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthError(message: response.message ?? 'Logout failed'));
    }
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await authRepository.isLoggedIn();
    if (isLoggedIn) {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }
}

