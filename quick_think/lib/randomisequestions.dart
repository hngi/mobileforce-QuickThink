import 'dart:math';

randomize(List questions) {
  int length = questions.length;
  List toReturn = [];
  while (questions.isNotEmpty) {
    toReturn.add(questions.removeAt(Random().nextInt(questions.length)));
  }
  return toReturn;
}
