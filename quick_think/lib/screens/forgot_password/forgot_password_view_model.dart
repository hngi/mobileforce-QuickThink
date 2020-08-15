import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quickthink/screens/login/services/enum/enum.dart';
import 'package:quickthink/screens/login/services/utils/loginUtil.dart';
import 'package:quickthink/screens/login/services/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'utils/forgotPasswordUtils.dart';

class ForgotPasswordState extends ChangeNotifier {
  ButtonState _buttonState = ButtonState.Idle;

  ButtonState get buttonState => _buttonState;

  void setState(ButtonState buttonState) {
    _buttonState = buttonState;
    notifyListeners();
  }

  Future<String> forgotPassword(String email, String password) async {
    setState(ButtonState.Pressed);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map data = {"email": email, "password": password};
    String payload = json.encode(data);
    Response response =
        await http.put(forgotPasswordUrl, headers: headers, body: payload);
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
    } else if (response.statusCode == 405) {
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance.showSnackBarError(error['error'] ?? 'Error');
      print(response.body);
      return null;
    } else if (response.statusCode == 200) {
      final Map user = json.decode(response.body);
      String apiKey = user['data']['id'].toString();
      SnackBarService.instance
          .showSnackBarSuccess('Password reset Successfully ');

      setState(ButtonState.Idle);
      return apiKey;
    }
    print(response.statusCode);
    setState(ButtonState.Idle);
    final Map error = json.decode(response.body);

    SnackBarService.instance.showSnackBarError(error['error'] ?? 'Error');
    return null;
  }
}
