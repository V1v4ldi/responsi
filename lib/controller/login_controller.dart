import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<String> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    if (prefs.containsKey('username')) {
      return "Akun sudah ada, silakan login";
    }

    await prefs.setString('username', username);
    await prefs.setString('password', password);
    return "Berhasil Register";
  }

  Future<String> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    
    final String? savedUser = prefs.getString('username');
    final String? savedPass = prefs.getString('password');

    if (savedUser == null) {
      return "Akun tidak ditemukan, silakan register dulu";
    }

    if (username == savedUser && password == savedPass) {
      _isLoggedIn = true;
      await prefs.setBool('isLoggedIn', true);
      notifyListeners();
      return "Berhasil Login";
    } else {
      return "Username atau Password salah";
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = false;
    await prefs.setBool('isLoggedIn', false); // Hapus sesi
    notifyListeners();
  }
}