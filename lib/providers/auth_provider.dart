import 'package:flutter/material.dart';
import 'package:videotron_rental/models/user_model.dart';
import 'package:videotron_rental/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? name,
    String? phone,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<bool> checkLogin({
  //   String token,
  // }) async {
  //   try {
  //     UserModel user = await AuthService().checkLogin(
  //       token: token,
  //     );
  //     _user = user;
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> logout({
    String? token,
  }) async {
    try {
      if (await AuthService().logout(
        token: token,
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? phone,
    String? token,
  }) async {
    try {
      UserModel user = await AuthService().updateProfile(
        name: name,
        phone: phone,
        token: token,
      );
      _user = user;
      return true;
    } catch (e) {
      print('${e}');
      return false;
    }
  }

  Future<bool> updatePassword({
    String? oldPassword,
    String? newPassword,
    String? newPasswordConfirmation,
    String? token,
  }) async {
    try {
      await AuthService().updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
        token: token,
      );
      return true;
    } catch (e) {
      print('${e}');
      return false;
    }
  }
}
