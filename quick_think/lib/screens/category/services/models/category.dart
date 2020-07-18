
class CategoryGame {
  String game;
  String userID;

  CategoryGame({this.game, this.userID});

  factory CategoryGame.fromMap(Map<String, dynamic> json) {
    return CategoryGame(
      game: json['name'],
      userID: json['user'].toString()
    );
  }
}