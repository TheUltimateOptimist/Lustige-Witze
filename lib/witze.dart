import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

List<List<dynamic>> witzeDaten = [
  ['akademiker-witze', 41],
  ['alle-kinder-sprueche', 388],
  ['arztwitze', 623],
  ['anwaltswitze', 49],
  ['arbeitswitze', 143],
  ['arztwitze', 623],
  ['bankerwitze', 155],
  ['bauernwitze', 32],
  ['bayern-witze', 12],
  ['beamtenwitze', 218],
  ['blondinenwitze', 1207],
  ['boese-witze', 25],
  ['bundeswehr-witze', 289],
  ['buerowitze', 129],
  ['chinesen-witze', 7],
  ['computerwitze', 173],
  ['deine-mutter-witze', 37],
  ['deutsche-witze', 11],
  ['drogen-witze', 12],
  ['familienwitze', 258],
  ['flachwitze', 32],
  ['fussballwitze', 35],
  ['geschichte-witze', 20],
  ['jaegerwitze', 25],
  ['juristen-witze', 80],
  ['kannibalen-witze', 31],
  ['kellnerwitze', 178],
  ['kinderwitze', 126],
  ['laenderwitze', 164],
  ['musikerwitze', 317],
  ['oesterreicher-witze', 66],
  ['ostfriesenwitze', 347],
  ['polenwitze', 36],
  ['politiker-witze', 147],
  ['polizei-witze', 132],
  ['schlechte-witze', 23],
  ['schulwitze', 225],
  ['sportwitze', 214],
  ['studentenwitze', 71],
  ['tierwitze', 311],
  ['urlaubswitze', 168],
  ['weihnachtswitze', 23],
  ['wortwitze', 22],
];

///returns a specific joke given the index of its category and its line
Future<String> getJoke(int index, int lineIndex) async {
  // Directory directory = await getApplicationDocumentsDirectory();
  // final File file = File(witzeDaten[index][0] + ".txt");
  // List<String> lines = file.readAsLinesSync();
  List<String> lines = (await rootBundle
          .loadString("gescrapteWitze/" + witzeDaten[index][0] + ".txt"))
      .split("\n");
  return lines[lineIndex];
}

///returns a random joke by first selecting a random category(every category has the same chances) and then selecting a random joke from that category
Future<String> getRandomJokeCategoryIndependent() async {
  int index = Random().nextInt(witzeDaten.length);
  int lineIndex = Random().nextInt(witzeDaten[index][1]);
  return await getJoke(index, lineIndex);
}

Future<String> getRandomJokeCategoryDependent() async {
  int number = Random().nextInt(7225);
  if (number >= witzeDaten[0][1]) {
    int currentIndex = 0;
    bool nextIndex = true;
    while (nextIndex) {
      number -= int.parse(witzeDaten[currentIndex][1].toString());
      currentIndex += 1;
      if ((number < witzeDaten[currentIndex][1])) {
        nextIndex = false;
      }
    }
    return await getJoke(currentIndex, number);
  } else {
    return await getJoke(0, number);
  }
}
