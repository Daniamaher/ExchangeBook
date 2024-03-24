import 'package:flutter/material.dart';
import 'package:flutter_application_1/exchangebook/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserP? _currentUser;

  UserP? get currentUser => _currentUser;

  void setCurrentUser(UserP? user) {
    _currentUser = user;
    notifyListeners();
  }
}