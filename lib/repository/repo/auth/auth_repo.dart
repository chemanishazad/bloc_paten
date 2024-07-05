import 'dart:convert';
import 'package:bloc_paten/core/domain/api_master.dart';
import 'package:bloc_paten/repository/model/auth/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<User> login(String username, String password) async {
    final response = await ApiMaster().fire(
      path: '/authentication',
      method: HttpMethod.$post,
      body: {'username': username, 'password': password},
      contentType: ContentType.urlEncoded, // Specify the content type here
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status_code'] == 202) {
        final user = User.fromJson(data['userInfo']);
        await _saveUserData(user);
        return user;
      } else {
        throw (data['message']);
      }
    } else {
      throw ('Failed to authenticate');
    }
  }

  Future<void> _saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setInt('userId', user.userId);
    await prefs.setString('userName', user.name);
    await prefs.setString('userEmail', user.email);
    await prefs.setString('username', user.username);
    if (user.deviceToken != null) {
      await prefs.setString('deviceToken', user.deviceToken!);
    }
  }

  Future<void> logout() async {
    final response = await ApiMaster().fire(
      path: '/authentication/logout',
      method: HttpMethod.$get,
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } else {
      throw ('Failed to log out');
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') ?? false) {
      return User(
        userId: prefs.getInt('userId')!,
        name: prefs.getString('userName')!,
        email: prefs.getString('userEmail')!,
        username: prefs.getString('username')!,
        deviceToken: prefs.getString('deviceToken'),
      );
    }
    return null;
  }
}
