import 'package:em_home/methods/auth_method.dart';
import 'package:flutter/material.dart';

import '../models/home_model.dart';
import '../models/model.dart';

// class UserProvider extends ChangeNotifier {
//   final AuthMethods _authMethods = AuthMethods();
//
//   User? _user;
//
//   User get getUser => _user!;
//
//   Future<void> refreshUser() async {
//     User user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
//
// }
//
// class HomeProvider extends ChangeNotifier {
//   final AuthMethods _authMethods = AuthMethods();
//
//   Home? _home;
//
//   Home get getHome => _home!;
//
//   Future<void> refreshHome() async {
//     Home home = await _authMethods.getHomeDetails();
//     _home = home;
//     notifyListeners();
//   }
//
// }