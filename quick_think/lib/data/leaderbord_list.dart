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
  int score;
  int gameCode;
  String category;

  Data({this.id, this.userName, this.score, this.gameCode, this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    score = json['score'];
    gameCode = json['game_code'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['score'] = this.score;
    data['game_code'] = this.gameCode;
    data['category'] = this.category;
    return data;
  }
}
