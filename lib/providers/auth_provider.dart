import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  final AuthService _authService = AuthService();

  User? get user => _user;

  Future<void> loadUser() async {
    _user = await _authService.getCurrentUser();
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}