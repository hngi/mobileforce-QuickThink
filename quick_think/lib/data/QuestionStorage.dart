import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quickthink/model/question_model.dart';
import 'dart:convert';

class QuestionStorage{
  String _difficulty;

  bool fileEmpty;

  String get difficulty => _difficulty;

  set difficulty(String value) {
    _difficulty = value;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${_difficulty}OfflineQuestions.json');
  }

  Future writeQuestions(String data) async {
    final file = await _localFile;

    String contents = file.readAsStringSync();

    if (contents.isEmpty) {
        file.writeAsString(data);
    }else{
      if (data.isNotEmpty){
        file.writeAsString(data);
      }
    }
  }

  Future readQuestions() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return 0;
    }
  }



}