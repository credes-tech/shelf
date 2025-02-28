import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/remote/firebase_service.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository_impl.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authRemoteDataSource = ref.read(authRemoteDataSourceProvider);
  return AuthRepository(authRemoteDataSource);
});

final authStateProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

class AuthNotifier extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(_authRepository.getCurrentUser());

  Future<void> signUp({required String email, required String password, required String name}) async {
    final user = await _authRepository.signUp(email: email, password: password, name: name);
    state = user;
  }

  Future<void> login({required String email, required String password}) async {
    final user = await _authRepository.login(email: email, password: password);
    state = user;
  }

  Future<void> googleSignIn() async {
    final user = await _authRepository.googleSignIn();
    state = user;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = null;
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _authRepository.sendPasswordResetEmail(email: email);
  }

  void _getCurrentUser() {
    state = _authRepository.getCurrentUser();
  }

  // Public method
  UserModel? getCurrentUser() {
    return state;
  }
}
