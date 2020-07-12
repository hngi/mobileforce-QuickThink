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
      
        _categories =
          apiData.map((item) => Categories.fromMap(item)).toList();
      
        return _categories;
      } else {
        throw Exception('Failed to retrieve code');
      }
  }
}
