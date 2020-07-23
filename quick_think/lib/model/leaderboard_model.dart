import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:quickthink/data/leaderbord_list.dart';

enum fetchState {Busy, DataRetrieved,NoData}
class LeaderboardModel{

  final StreamController<fetchState> _stateController = StreamController<fetchState>.broadcast();

  Stream<fetchState> get leaderboardState => _stateController.stream;

  List<Data> listData;

Future<List<LeaderboardList>> getLeaderboard(String gameCode) async {

  _stateController.add(fetchState.Busy);

  final String fetchUrl = "http://brainteaser.pythonanywhere.com/game/code/leaderboard?n=100&game_code=$gameCode";
  Response data = await get(fetchUrl);

  if(data.statusCode == 200){
    var results = jsonDecode(data.body);
    if(results != null){
      listData = LeaderboardList.fromJson(results).data;
      
      _stateController.add(fetchState.DataRetrieved);
    }else{
      _stateController.add(fetchState.NoData);
    }
  }else{
    _stateController.addError("Oops! We could not fetch the Leaderboard at this time. \nPlease try again later");
  }

}

}