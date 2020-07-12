import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:quickthink/data/leaderbord_list.dart';

enum fetchState {Busy, DataRetrieved,NoData}
class LeaderboardModel{

  final StreamController<fetchState> _stateController = StreamController<fetchState>.broadcast();

  List<User> listUsers;

  Stream<fetchState> get leaderboardState => _stateController.stream;

Future<List<LeaderboardList>> getLeaderboard(String gameCode) async {

  _stateController.add(fetchState.Busy);

  final String fetchUrl = "http://mohammedadel.pythonanywhere.com/game/code/leaderboard?n=20&game_code=$gameCode";
  Response data = await get(fetchUrl);

  if(data.statusCode == 200){
    var results = jsonDecode(data.body);
    if(results != null){
      final List<Data> listData = LeaderboardList.fromJson(results).data;

      listUsers = getUsers(listData);
      
      _stateController.add(fetchState.DataRetrieved);
    }else{
      _stateController.add(fetchState.NoData);
    }
  }else{
    _stateController.addError("Oops! We could not fetch the Leaderboard at this time. \n Please try again later");
  }

}

List<User> getUsers(List<Data> data){
  List<User> users = [];

  data.forEach((element) {
    users.add(element.user);
  });


  return users;
}


}