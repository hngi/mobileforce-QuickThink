class LeaderboardList {
  List<Data> _data;

  LeaderboardList({List<Data> data}) {
    this._data = data;
  }

  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  LeaderboardList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String _id;
  int _score;
  int _gameCode;
  String _category;
  User _user;

  Data({String id, int score, int gameCode, String category, User user}) {
    this._id = id;
    this._score = score;
    this._gameCode = gameCode;
    this._category = category;
    this._user = user;
  }

  String get id => _id;
  set id(String id) => _id = id;
  int get score => _score;
  set score(int score) => _score = score;
  int get gameCode => _gameCode;
  set gameCode(int gameCode) => _gameCode = gameCode;
  String get category => _category;
  set category(String category) => _category = category;
  User get user => _user;
  set user(User user) => _user = user;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _score = json['score'];
    _gameCode = json['game_code'];
    _category = json['category'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['score'] = this._score;
    data['game_code'] = this._gameCode;
    data['category'] = this._category;
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }
}

class User {
  String _id;
  String _name;
  String _emailAddress;
  String _password;
  int _score;

  User({String id, String name, String emailAddress, String password, int score}) {
    this._id = id;
    this._name = name;
    this._emailAddress = emailAddress;
    this._password = password;
    this._score = score;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  Null get emailAddress => _emailAddress;
  set emailAddress(Null emailAddress) => _emailAddress = emailAddress;
  Null get password => _password;
  set password(Null password) => _password = password;
  int get score => _score;
  set score(int score) => _score = score;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _emailAddress = json['email_address'];
    _password = json['password'];
    _score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email_address'] = this._emailAddress;
    data['password'] = this._password;
    data['score'] = this._score;
    return data;
  }
}
