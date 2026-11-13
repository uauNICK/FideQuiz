import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fidequiz/services/auth_service.dart';
import 'package:fidequiz/services/firestore_service.dart';
import 'package:fidequiz/models/user_profile.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _user;
  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get isAnonymous => _user?.isAnonymous ?? false;

  String get displayName =>
      _userProfile?.displayName.isNotEmpty == true
          ? _userProfile!.displayName
          : (_user?.displayName?.isNotEmpty == true
              ? _user!.displayName!
              : (isAnonymous ? 'Peregrino Anônimo' : 'Fiel Católico'));

  AuthProvider() {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((User? user) async {
      _user = user;
      if (user != null) {
        await _loadProfile(user.uid);
      } else {
        _userProfile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadProfile(String uid) async {
    _userProfile = await _firestoreService.getUserProfile(uid);
    if (_userProfile == null && _user != null) {
      _userProfile = UserProfile(
        id: uid,
        displayName: _user!.displayName ?? 'Fiel Católico',
        email: _user!.email ?? '',
        photoUrl: _user!.photoURL ?? '',
        patronSaint: 'São Miguel Arcanjo',
        totalScore: 0,
        totalGames: 0,
        totalCorrect: 0,
        totalQuestions: 0,
        streak: 0,
        bestStreak: 0,
        badges: ['iniciante'],
        createdAt: DateTime.now(),
        lastPlayedAt: DateTime.now(),
      );
      await _firestoreService.saveUserProfile(_userProfile!);
    }
    notifyListeners();
  }

  Future<bool> signInWithEmail(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.signInWithEmail(email, password);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _parseAuthError(e);
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _parseAuthError(e);
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      final credential = await _authService.signInWithGoogle();
      _setLoading(false);
      return credential != null;
    } catch (e) {
      _errorMessage = 'Falha no login com Google. Tente novamente.';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signInAnonymously() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.signInAnonymously();
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Não foi possível entrar como visitante.';
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _userProfile = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _parseAuthError(dynamic error) {
    final str = error.toString().toLowerCase();
    if (str.contains('user-not-found') || str.contains('wrong-password') || str.contains('invalid-credential')) {
      return 'E-mail ou senha incorretos.';
    } else if (str.contains('email-already-in-use')) {
      return 'Este e-mail já está cadastrado.';
    } else if (str.contains('weak-password')) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    } else if (str.contains('invalid-email')) {
      return 'Formato de e-mail inválido.';
    }
    return 'Ocorreu um erro ao autenticar. Verifique sua conexão.';
  }
}
