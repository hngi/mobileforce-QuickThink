import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:quickthink/data/leaderbord_list.dart';

enum fetchState {Busy, DataRetrieved,NoData}
class LeaderboardModel{

  final StreamController<fetchState> _stateController = StreamController<fetchState>.broadcast();

  Stream<fetchState> get leaderboardState => _stateController.stream;

  final StreamController<fetchState> _headerController = StreamController<fetchState>.broadcast();

  Stream<fetchState> get headerState => _headerController.stream;

  List<Data> listData;

Future<List<LeaderboardList>> getLeaderboard(String gameCode) async {

  _stateController.add(fetchState.Busy);
  _headerController.add(fetchState.Busy);

  final String fetchUrl = "https://brainteaserdev.pythonanywhere.com//usergame/leaderboard/game/$gameCode/100/";

  Response inData = await get(fetchUrl);

  if(inData.statusCode == 200){
    var results = jsonDecode(inData.body);
    if(results != null){

      _stateController.add(fetchState.DataRetrieved);
      _headerController.add(fetchState.DataRetrieved);
      listData = LeaderboardList.fromJson(results).data;

    }else{
      _stateController.add(fetchState.NoData);
      _headerController.add(fetchState.NoData);
    }
  }else{
    _stateController.addError("Oops! We could not fetch the Leaderboard at this time. \nPlease try again later");
    _headerController.addError("Oops! We could not fetch the Leaderboard at this time. \nPlease try again later");
  }

}

}