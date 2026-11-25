import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

/// Holds the in-memory authentication token for the current session.
class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken}) : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  String? get token => _token;

  bool get isLoggedIn => _token != null;

  // Login dan menyimpan token dari Django.
  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);
    notifyListeners();
  }

  // Logout dan menghapus token.
  Future<void> logout() async {
    final current = _token;

    if (current == null) return;

    try {
      await _apiClient.logout(token: current);
    } on ApiException {
      // Tetap logout secara lokal meskipun server menolak request.
    } finally {
      _token = null;
      notifyListeners();
    }
  }
}
