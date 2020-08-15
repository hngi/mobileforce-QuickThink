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
        'Authorization': 'Token $token'
      };
      Map data = {"name": category};
      String payload = json.encode(data);
      Response response =
          await http.post(categoryUrl, headers: headers, body: payload);
      if (response.statusCode == 500) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance
            .showSnackBarError(error['error'] ?? error['name'][0]);

        return null;
      } else if (response.statusCode == 404) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance
            .showSnackBarError(error['error'] ?? error['name'][0]);
        return null;
      } else if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance
            .showSnackBarError(error['error'] ?? error['name'][0]);
        return null;
      } else if (response.statusCode == 200) {
        final Map user = json.decode(response.body);
        String catName = user['name'];
        SnackBarService.instance
            .showSnackBarSuccess('Category $catName created successfully');
        print(user);
        setState(ButtonState.Idle);

        return catName;
      }
      print(response.statusCode);
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance
          .showSnackBarError(error['error'] ?? error['name'][0]);
      print(error);
      return null;
    }
    return null;
  }

  Future<List> getUserCategory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token != null) {
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token'
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
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> createQuestion(Questions questions) async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(token);
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
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
      print(response.statusCode);
      if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        final Map user = json.decode(response.body);
        String error = user['error'];
        SnackBarService.instance
            .showSnackBarError(error ?? 'Some error occured');
        return null;
      } else if (response.statusCode == 200) {
        final Map list = json.decode(response.body);
        print(list);
        final Map listt = list['data'];
        setState(ButtonState.Idle);
        SnackBarService.instance
            .showSnackBarSuccess('Question created successfully');

        return listt['id'];
      }
      print(response.statusCode);
      setState(ButtonState.Idle);
      final Map user = json.decode(response.body);
      String error = user['error'];
      SnackBarService.instance.showSnackBarError(error);
      return null;
    }
    return null;
  }

  Future<String> logout() async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      // Map<String, String> headers = {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Token $token'
      // };
      // Response response = await http.post(logoutUrl, headers: headers);
      // if (response.statusCode == 200) {
      setState(ButtonState.Idle);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', null);
      pref.setString('username', null);
      // final Map list = json.decode(response.body);
      // final listt = list['data'];
      return 'logged out';
      // } else {
      //   print(response.statusCode);
      //   setState(ButtonState.Idle);
      //   SnackBarService.instance.showSnackBarError('Server Error. Try again');
      //   return null;
      // }
    }
    return null;
  }

  Future<String> deleteAccount() async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      Response response = await http.delete(deleteAccountUrl, headers: headers);
      print(response.statusCode);
      print(token);
      if (response.statusCode == 200) {
        setState(ButtonState.Idle);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', null);
        pref.setString('username', null);
        final Map list = json.decode(response.body);
        print(list);
        SnackBarService.instance
            .showSnackBarSuccess('Account Deleted succesfully');
        final listt = list['data'];
        print("List: $list");
        print(response.statusCode);
        return listt;
      } else {
        print(response.statusCode);
        setState(ButtonState.Idle);
        SnackBarService.instance.showSnackBarError('Server Error. Try again');
        print(response.body);
        print(response.statusCode);
        return null;
      }
    }
    return null;
  }

  Future<List> getUserQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token != null) {
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Token $token'
        };
        Response response = await http.get(getUsersQuestions, headers: headers);
        if (response.statusCode == 200) {
          final Map list = json.decode(response.body);
          final List listt = list['data'];
          List<Questions> _list = [];
          for (var i = 0; i < listt.length; i++) {
            _list.add(Questions(
              id: listt[i]['id'],
              question: listt[i]['question'],
              category: listt[i]['category'],
              answer: listt[i]['answer'],
              options: listt[i]['options'],
            ));
          }
          return listt;
        } else {
          print(response.statusCode);
          // SnackBarService.instance.showSnackBarError('Server Error. Try again');
          return null;
        }
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> editQuestion(Questions questions) async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      Map data = {
        "Question": {
          "id": questions.id,
          "category": questions.category,
          "question": questions.question,
          "answer": questions.answer,
          "options": questions.options,
        },
      };
      String payload = json.encode(data);
      Response response =
          await http.put(editQuestionsUrl, headers: headers, body: payload);
      if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance.showSnackBarError(error['error']);
        return null;
      } else if (response.statusCode == 200) {
        final Map list = json.decode(response.body);
        print(list);
        final Map listt = list['data'];
        SnackBarService.instance
            .showSnackBarSuccess('Question updated successfully');
        setState(ButtonState.Idle);

        return listt['id'];
      }
      print(response.statusCode);
      final Map error = json.decode(response.body);
      setState(ButtonState.Idle);
      SnackBarService.instance.showSnackBarError(error['error']);
      return null;
    }
    return null;
  }

  Future<String> deleteQuestion(String id, String name) async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      Map data = {/* "name": name, */ "id": id};
      String payload = json.encode(data);
      Response response =
          await http.post(deleteQuestionUrl, headers: headers, body: payload);
      if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        // final Map error = json.decode(response.body);
        SnackBarService.instance.showSnackBarError('Some error occured');
        return null;
      } else if (response.statusCode == 200) {
        // final Map list = json.decode(response.body);
        // final Map listt = list['data'];
        setState(ButtonState.Idle);
        SnackBarService.instance
            .showSnackBarSuccess('Question deleted successfully');

        return 'deleted';
      }
      print(response.statusCode);
      print(id);
      setState(ButtonState.Idle);
      // final Map error = json.decode(response.body);
      SnackBarService.instance.showSnackBarError('Some error occured');
      return null;
    }
    return null;
  }

  Future<String> deleteCategory(String name) async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print(name);
    print(token);

    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      Map data = {"category": name};
      var url = Uri.parse(deleteCategoryUrl + '$name/');
      print('URL: $url');
      String payload = json.encode(data);
      Response response = await http.delete(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance.showSnackBarError(error['error'] ?? 'Error');
        return null;
      } else if (response.statusCode == 200) {
        setState(ButtonState.Idle);
        print('here');
        SnackBarService.instance
            .showSnackBarSuccess('$name Category deleted successfully');

        return 'deleted';
      }
      print(response.statusCode);
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance.showSnackBarError(error['error'] ?? 'Error');
      print(error);
      return null;
    }
    return null;
  }

  Future<String> editCategory(String categoryname, String newName) async {
    setState(ButtonState.Pressed);
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token != null) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      Map data = {
        "name": categoryname,
        "newname": newName,
      };
      String payload = json.encode(data);
      Response response =
          await http.put(editCategoryUrl, headers: headers, body: payload);
      if (response.statusCode == 500) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance
            .showSnackBarError(error['error'] ?? error['name'][0]);
        return null;
      } else if (response.statusCode == 404) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance
            .showSnackBarError(error['error'] ?? error['name'][0]);
        return null;
      } else if (response.statusCode == 400) {
        setState(ButtonState.Idle);
        final Map error = json.decode(response.body);
        SnackBarService.instance
            .showSnackBarError(error['error'] ?? error['name'][0]);
        return null;
      } else if (response.statusCode == 200) {
        final Map user = json.decode(response.body);

        SnackBarService.instance
            .showSnackBarSuccess('Category updated successfully');
        setState(ButtonState.Idle);

        return 'Success';
      }
      print(response.statusCode);
      setState(ButtonState.Idle);
      final Map error = json.decode(response.body);
      SnackBarService.instance
          .showSnackBarError(error['error'] ?? error['name'][0]);
      return null;
    }
    return null;
  }
}
