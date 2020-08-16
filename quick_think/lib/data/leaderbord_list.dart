class LeaderboardList {
  List<Data> data;

  LeaderboardList({this.data});

  LeaderboardList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String userName;
  Null emailAddress;
  int score;
  String createdAt;
  String updatedAt;
  Null time;
  int gameCode;
  List<String> category;

  Data(
      {this.id,
        this.userName,
        this.emailAddress,
        this.score,
        this.createdAt,
        this.updatedAt,
        this.time,
        this.gameCode,
        this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    emailAddress = json['email_address'];
    score = json['score'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    time = json['time'];
    gameCode = json['game_code'];
    category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['email_address'] = this.emailAddress;
    data['score'] = this.score;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['time'] = this.time;
    data['game_code'] = this.gameCode;
    data['category'] = this.category;
    return data;
  }
}
