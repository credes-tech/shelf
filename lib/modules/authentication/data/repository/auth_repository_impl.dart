import '../datasource/remote/firebase_service.dart';
import '../model/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepository(this._authRemoteDataSource);

  // Sign Up
  Future<UserModel?> signUp({required String email, required String password, required String name,}) async {
    return await _authRemoteDataSource.signUp(email: email, password: password, name: name,);
  }

  // Login
  Future<UserModel?> login({required String email, required String password}) async {
    return await _authRemoteDataSource.login(email: email, password: password);
  }

  //Google sign in
  Future<UserModel?> googleSignIn() async {
    return await _authRemoteDataSource.signInWithGoogle();
  }

  // Logout
  Future<void> logout() async {
    await _authRemoteDataSource.logout();
  }

  // Get Current User
  UserModel? getCurrentUser() {
    return _authRemoteDataSource.getCurrentUser();
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    return await _authRemoteDataSource.sendPasswordResetEmail(email: email);
  }
}
