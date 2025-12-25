import 'package:equatable/equatable.dart';
import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/repositories/auth_repository.dart';
import 'package:ezdu/features/auth/models/auth_model.dart';
import 'package:ezdu/services/dio_client.dart';
import 'package:ezdu/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final AuthModel? data;
  final String? error;
  final String? intendedRoute;

  const AuthState({
    required this.isLoading,
    this.data,
    this.error,
    this.intendedRoute,
  });

  const AuthState.initial()
    : isLoading = false,
      data = null,
      error = null,
      intendedRoute = null;

  AuthState copyWithLoading() {
    return AuthState(
      isLoading: true,
      data: data,
      error: null,
      intendedRoute: null,
    );
  }

  AuthState copyWithSuccess(AuthModel authData) {
    return AuthState(isLoading: false, data: authData, error: null);
  }

  AuthState copyWithError(String errorMsg) {
    return AuthState(isLoading: false, data: data, error: errorMsg);
  }

  AuthState copyWithRoute(String? route) {
    return AuthState(
      isLoading: isLoading,
      data: data,
      error: error,
      intendedRoute: route,
    );
  }

  bool get isLoggedIn => data != null;

  @override
  List<Object?> get props => [];
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._repository) : super(const AuthState.initial());

  final AuthRepository _repository;

  Future<void> login(String email, String password) async {
    state = state.copyWithLoading();

    final response = await _repository.login(email, password);

    if (response.success && response.data != null) {
      state = state.copyWithSuccess(response.data!);
    } else {
      state = state.copyWithError(response.message ?? "Login failed");
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.initial();
  }

  void copyWith({
    int? id,
    required String username,
    required String name,
    String? token,
  }) {
    state = state.copyWithSuccess(
      AuthModel(
        id: id ?? state.data!.id,
        name: name,
        userName: username,
        token: token ?? state.data!.token,
      ),
    );
  }

  Future<void> restoreSession() async {
    final storageService = sl<StorageService>();
    final dioClient = sl<DioClient>();

    final authData = await storageService.getAuthData();
    final token = await storageService.getToken();

    if (authData != null && token != null) {
      dioClient.setAuthToken(token);
      state = state.copyWithSuccess(authData);

      // print('->->->->->->->->->-> Authenticated');
    }
  }

  void setIntendedRoute(String route) {
    state = state.copyWithRoute(route);
  }

  void clearIntendedRoute() {
    state = state.copyWithRoute(null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(sl<AuthRepository>()),
);

final authInitProvider = FutureProvider<void>((ref) async {
  await ref.read(authProvider.notifier).restoreSession();
});
