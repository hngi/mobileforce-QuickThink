import 'dart:convert';

import 'package:http/http.dart' as http;

class Categories {
  String name;

  Categories({
    this.name,
  });

  factory Categories.fromMap(Map<String, dynamic> json) {
    return Categories(
      name: json['name'],
    );
  }
}

class Services {
  Future<List<Categories>> getCategories() async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      String url = 'http://mohammedadel.pythonanywhere.com/game/category';
      http.Response response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        List<Categories> _categories = [];
        List apiData = jsonDecode(response.body)['data'];
        print('ApiData $apiData');

        for (var i = 0; i < apiData.length; i++) {
          _categories.add(
            Categories(
              name: apiData[i]['name'],
            ),
          );
        }
        // _categories =
        //     apiData.map((item) => new Categories.fromMap(item)).toList();
        print(_categories);
        return _categories;
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
