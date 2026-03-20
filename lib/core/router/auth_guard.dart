import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}

// What this is:
//  AuthNotifier is a ChangeNotifier that holds auth state. GoRouter will listen to it
//  and re-evaluate redirects whenever notifyListeners() is called — i.e., when the user
//   logs in or out.