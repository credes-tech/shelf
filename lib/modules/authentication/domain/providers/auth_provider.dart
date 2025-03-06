import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_shelf_project/modules/authentication/data/datasource/remote/firebase_service.dart';
import 'package:my_shelf_project/modules/authentication/data/model/user_model.dart';
import 'package:my_shelf_project/modules/authentication/data/repository/auth_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  bool isOnboarded = false; // Stores onboarding state

  AuthNotifier(this._authRepository) : super(null) {
    Future.microtask(() => _loadUserState());
  }

  Future<void> signUp({required String email, required String password, required String name}) async {
    final user = await _authRepository.signUp(email: email, password: password, name: name);
    if (user != null) {
      await _saveLoginState(true);
    }
    state = user;
  }

  Future<void> login({required String email, required String password}) async {
    final user = await _authRepository.login(email: email, password: password);
    if (user != null) {
      await _saveLoginState(true);
    }
    state = user;
  }

  Future<void> googleSignIn() async {
    final user = await _authRepository.googleSignIn();
    if(user != null) {
      await _saveLoginState(true);
    }
    state = user;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    await _saveLoginState(false);
    state = null;
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await _authRepository.sendPasswordResetEmail(email: email);
  }

  Future<void> _saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> _loadUserState() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    isOnboarded = prefs.getBool('isOnboarded') ?? false; // Load onboarding state

    if (isLoggedIn) {
      state = _authRepository.getCurrentUser();
    }
  }

  Future<void> completedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboarded', true);
    isOnboarded = true;
  }

  bool getOnboardingStatus() {
    return isOnboarded;
  }
}
