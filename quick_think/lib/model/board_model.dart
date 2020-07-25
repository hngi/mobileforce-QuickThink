import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


enum fetchState {Busy, DataRetrieved,NoData}

class BoardModel{
  final StreamController<fetchState> _playedStateController = StreamController<fetchState>.broadcast();
  final StreamController<fetchState> _createdStateController = StreamController<fetchState>.broadcast();

  Stream<fetchState> get playedState => _playedStateController.stream;
  Stream<fetchState> get createdState => _createdStateController.stream;

  List<String> playedGames;
  List<String> createdGames;

  Future<List<String>> getCreatedPrefs(String key) async {

    _createdStateController.add(fetchState.Busy);

    final sharedPreferences = await SharedPreferences.getInstance();
    final valueStored = sharedPreferences.getStringList(key) ?? [];
    print('List Retrieved with Play Game Codes in Join Game: $valueStored');

    if(valueStored != null || valueStored.length != 0){
      if(valueStored.length > 15){
        for(var i = 0; i < 15; i++){
          createdGames.add(valueStored[i]);
        }
      }else {
        createdGames = valueStored;
      }
      _createdStateController.add(fetchState.DataRetrieved);
    }else{
      _createdStateController.add(fetchState.NoData);
    }
  }

  Future<List<String>> getPlayedPrefs(String key) async {

    _playedStateController.add(fetchState.Busy);

    final sharedPreferences = await SharedPreferences.getInstance();
    final valueStored = sharedPreferences.getStringList(key) ?? [];
    print('List Retrieved with Play Game Codes in Join Game: $valueStored');

    if(valueStored != null || valueStored.length != 0){
      if(valueStored.length > 15){
        for(var i = 0; i < 15; i++){
          playedGames.add(valueStored[i]);
        }
      }else {
        playedGames = valueStored;
      }
      _playedStateController.add(fetchState.DataRetrieved);
    }else{
      _playedStateController.add(fetchState.NoData);
    }
  }
}