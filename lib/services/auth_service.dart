import 'dart:convert';

import 'package:videotron_rental/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'https://karindo.jasproweb.com/api';

  Future<UserModel> register({
    String? name,
    String? phone,
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  // Future<UserModel> checkLogin({
  //   String token,
  // }) async {
  //   var url = '$baseUrl/check-login';
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': token,
  //   };

  //   var response = await http.post(
  //     url as Uri,
  //     headers: headers,
  //   );

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body)['data'];
  //     UserModel user = UserModel.fromJson(data);
  //     user.token = token;

  //     return user;
  //   } else {
  //     throw Exception('Token Expired');
  //   }
  // }

  Future<UserModel> updateProfile({
    String? name,
    String? phone,
    String? token,
  }) async {
    var url = '$baseUrl/update/profile';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token!,
    };
    var body = jsonEncode({
      'name': name,
      'phone': phone,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = token;
      return user;
    } else {
      throw Exception('Gagal Update Profile');
    }
  }

  Future<bool> updatePassword({
    String? oldPassword,
    String? newPassword,
    String? newPasswordConfirmation,
    String? token,
  }) async {
    var url = '$baseUrl/update/password';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token!,
    };
    var body = jsonEncode({
      'old_password': oldPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Update Password');
    }
  }

  Future<bool> logout({
    String? token,
  }) async {
    var url = '$baseUrl/logout';
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token!,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Token Expired');
    }
  }
}
