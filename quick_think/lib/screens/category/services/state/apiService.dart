import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:quickthink/screens/category/services/models/category.dart';
import 'package:quickthink/screens/category/services/models/questions.dart';
import 'package:quickthink/screens/category/services/utils/utils.dart';
import 'package:quickthink/screens/login/services/enum/enum.dart';
import 'package:quickthink/screens/login/services/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCallService with ChangeNotifier {
  ButtonState _buttonState = ButtonState.Idle;

  ButtonState get buttonState => _buttonState;

  List<CategoryGame> _category = [];

  List<CategoryGame> get categoryList => _category;

  set categoryList(List<CategoryGame> categoryList) {
    _category = categoryList;
    notifyListeners();
  }

  void setState(ButtonState buttonState) {
    _buttonState = buttonState;
    notifyListeners();
  }

  Future<String> createCategory(String category) async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      Map data = {"name": category};
      String payload = json.encode(data);
      Response response =
          await http.post(categoryUrl, headers: headers, body: payload);
      if (response.statusCode == 500) {
        setState(ButtonState.Idle);
        SnackBarService.instance.showSnackBarError('Server Error. Try again');
        return null;
      } else if (response.statusCode == 404) {
        setState(ButtonState.Idle);
        SnackBarService.instance.showSnackBarError('Category already exists');
        return null;
      } else if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        SnackBarService.instance.showSnackBarError('Category already exists');
        return null;
      } else if (response.statusCode == 201) {
        final Map user = json.decode(response.body);
        String catName = user['name'];
        SnackBarService.instance
            .showSnackBarSuccess('Category ${catName} created successfully');
        setState(ButtonState.Idle);

        return catName;
      }
      print(response.statusCode);
      setState(ButtonState.Idle);
      SnackBarService.instance.showSnackBarError('Server Error. Try again');
      return null;
    }
    return null;
  }

  Future<List> getUserCategory() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      Response response = await http.get(getUsersCategory, headers: headers);
      if (response.statusCode == 200) {
        final Map list = json.decode(response.body);
        final List listt = list['data'];
        List<CategoryGame> _list = [];
        for (var i = 0; i < listt.length; i++) {
          _list.add(CategoryGame(
              game: listt[i]['name'], userID: listt[i]['user'].toString()));
        }
        return listt;
      } else {
        print(response.statusCode);
        // SnackBarService.instance.showSnackBarError('Server Error. Try again');
        return null;
      }
    }
    return null;
  }

  Future<String> createQuestion(Questions questions) async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      Map data = {
        "Question": {
          "category": questions.category,
          "question": questions.question,
          "answer": questions.answer,
          "options": questions.options,
        },
      };
      String payload = json.encode(data);
      Response response =
          await http.post(questionUrl, headers: headers, body: payload);
      if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        SnackBarService.instance.showSnackBarError('Enter Valid Category');
        return null;
      } else if (response.statusCode == 200) {
        final Map list = json.decode(response.body);
        final Map listt = list['data'];
        SnackBarService.instance
            .showSnackBarSuccess('Question created successfully');
        setState(ButtonState.Idle);

        return listt['id'];
      }
      print(response.statusCode);
      setState(ButtonState.Idle);
      SnackBarService.instance.showSnackBarError('Server Error. Try again');
      return null;
    }
    return null;
  }

  Future<String> logout() async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      Response response = await http.post(logoutUrl, headers: headers);
      if (response.statusCode == 200) {
        setState(ButtonState.Idle);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', null);
        pref.setString('username', null);
        final Map list = json.decode(response.body);
        final listt = list['data'];
        return listt;
      } else {
        print(response.statusCode);
        setState(ButtonState.Idle);
        SnackBarService.instance.showSnackBarError('Server Error. Try again');
        return null;
      }
    }
    return null;
  }
}
