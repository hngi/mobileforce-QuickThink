import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enum/enum.dart';
import 'package:http/http.dart' as http;

import '../utils/loginUtil.dart';
import '../utils/snackbar.dart';

class LoginState extends ChangeNotifier {
  ButtonState _buttonState = ButtonState.Idle;

  ButtonState get buttonState => _buttonState;

  void setState(ButtonState buttonState) {
    _buttonState = buttonState;
    notifyListeners();
  }

  Future<String> login(String username, String password) async {
    setState(ButtonState.Pressed);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map data = {"username": username, "password": password};
    String payload = json.encode(data);
    Response response =
        await http.post(loginUrl, headers: headers, body: payload);
    print(response.statusCode);
    if (response.statusCode == 500) {
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance.showSnackBarError(error['error']);
      return null;
    } else if (response.statusCode == 404) {
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance.showSnackBarError(error['error']);
      return null;
    } else if (response.statusCode == 400) {
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance
          .showSnackBarError(error['error']);
      return null;
    } else if (response.statusCode == 200) {
      final Map user = json.decode(response.body);
      String apiKey = user['user']['id'].toString();
      SnackBarService.instance
          .showSnackBarSuccess('Welcome back ${user['user']['username']}');
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('username', user['user']['username']);
      await preferences.setString('token', user['token']);
      setState(ButtonState.Idle);

      print(apiKey);
      return apiKey;
    }
    print(response.statusCode);
    setState(ButtonState.Idle);
    final Map error = json.decode(response.body);
    
    SnackBarService.instance.showSnackBarError(error['error']);
    return null;
  }

  Future<String> signup(String username, String email, String password) async {
    setState(ButtonState.Pressed);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map data = {"username": username, "email": email, "password": password};
    String payload = json.encode(data);
    Response response =
        await http.post(regUrl, headers: headers, body: payload);
    print(response.statusCode);
    if (response.statusCode == 500) {
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance.showSnackBarError(error['error']);
      return null;
    } else if (response.statusCode == 400) {
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance
          .showSnackBarError(error['error']);
      return null;
    } else if (response.statusCode == 200) {
      final Map user = json.decode(response.body);
      String apiKey = user['id'].toString();
      SnackBarService.instance
          .showSnackBarSuccess('Account created for ${user['username']}');
      final preferences = await SharedPreferences.getInstance();
      await preferences.setString('userID', apiKey);
      setState(ButtonState.Idle);

      print(apiKey);
      return apiKey;
    }
    print(response.statusCode);
    setState(ButtonState.Idle);
    final Map error = json.decode(response.body);
    SnackBarService.instance.showSnackBarError(error['error']);
    return null;
  }
}
