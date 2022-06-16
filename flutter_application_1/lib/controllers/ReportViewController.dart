// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/TurnController.dart';
import 'package:get/get.dart';

import '../utils/appFunctions.dart';

//Controller of main report data
class ReportViewController extends GetxController {
  //Main data
  RxList<TurnController> _turns =
      [new TurnController(), new TurnController()].obs;
  RxList<TurnController> get turns => _turns;

  TextEditingController _enemyName = TextEditingController();
  TextEditingController get enemyName => _enemyName;

  String determineType(int indexTurn, int indexChara) {
    String data = "";

    switch (turns[indexTurn].characters[indexChara].type.value) {
      case "Fire":
        data += ":red";
        break;
      case "Ice":
        data += ":blue";
        break;
      case "Earth":
        data += ":green";
        break;
      case "Light":
        data += ":yellow";
        break;
      case "Dark":
        data += ":purple";
        break;

      default:
        data += ":white";
        break;
    }

    data += "_circle: __**" +
        (turns[indexTurn].characters[indexChara].name.value.text != ""
            ? turns[indexTurn].characters[indexChara].name.value.text
            : "?");

    return data;
  }

  //Building the report

  //Enemy name
  String determineEnemyName() {
    String data = "";

    if (enemyName.value.text != "") {
      data += "__**" + enemyName.value.text.trim() + " :**__\n\n";
    }

    return data;
  }

  //Enemy speed
  String calculateSpeed(int indexTurn, int indexChara) {
    String finalResult = "";
    int result = 0;

    if (turns[indexTurn].speedFirstCharacter.text.isEmpty ||
        turns[indexTurn].characters[indexChara].cr.value.text == '') {
      finalResult = "?";
    } else {
      result = turns[indexTurn].calculteRealSpeed();
      int crChara =
          int.parse(turns[indexTurn].characters[indexChara].cr.value.text);
      if (turns[indexTurn].characters[indexChara].crPush.value.text != '') {
        crChara -= int.parse(
            turns[indexTurn].characters[indexChara].crPush.value.text);
      }
      if (turns[indexTurn].characters[indexChara].crDepush.value.text != '') {
        crChara += int.parse(
            turns[indexTurn].characters[indexChara].crDepush.value.text);
      }

      if (turns[indexTurn].characters[indexChara].hasEnemyOutspeed.value) {
        crChara += 100;
      }

      result = (result.toDouble() * ((crChara) / 100)).toInt();

      finalResult += "~";

      if (result % 5 == 1) {
        result -= 1;
      } else if (result % 5 == 4) {
        result += 1;
      } else if (result % 5 != 0) {
        result += (5 - (result % 5));
      }

      finalResult += result.toString();
    }

    return finalResult;
  }

  //Enemy HP
  String determineHP(int indexTurn, int indexChara) {
    String data = "> **";

    if (turns[indexTurn].characters[indexChara].isHpEnabled.value) {
      data += AppFunctions.convertNumber(
          turns[indexTurn].characters[indexChara].hp.value);
    } else {
      data += "?";
    }
    data += "** HP\n";

    return data;
  }

  //Enemy sets
  String determineSets(int indexTurn, int indexChara) {
    String data = "";

    List<String> sets = [];

    if ((turns[indexTurn].characters[indexChara].hasImmunity.value ||
        turns[indexTurn].characters[indexChara].set.value != "None")) {
      data += "> ";
      if (turns[indexTurn].characters[indexChara].hasImmunity.value) {
        sets.add(":muscle:");
      }
      switch (turns[indexTurn].characters[indexChara].set.value) {
        case "Counter":
          sets.add(":punch:");
          break;
        case "Lifesteal":
          sets.add(":drop_of_blood:");
          break;
        case "Injury":
          sets.add(":broken_heart:");
          break;

        default:
          break;
      }
    }
    if (sets.isNotEmpty) {
      for (int k = 0; k < sets.length; k++) {
        data += sets[k];
        if (k < (sets.length - 1)) {
          data += " / ";
        }
      }
      data += "\n";
    }

    return data;
  }

  //Enemy artifact
  String determineArtifact(int indexTurn, int indexChara) {
    String data = "> `";

    if (turns[indexTurn]
        .characters[indexChara]
        .artifact
        .value
        .text
        .trim()
        .isNotEmpty) {
      data +=
          turns[indexTurn].characters[indexChara].artifact.value.text.trim();
    } else {
      data += "?";
    }

    data += "`\n";

    return data;
  }

  //Enemy additionnal infos
  String determineComment(int indexTurn, int indexChara) {
    String data = "";

    if (turns[indexTurn]
        .characters[indexChara]
        .additionalInfos
        .value
        .text
        .isNotEmpty) {
      data += "> *" +
          turns[indexTurn]
              .characters[indexChara]
              .additionalInfos
              .value
              .text
              .trim() +
          "*\n";
    }

    return data;
  }

  //Building call
  String processData() {
    String data = "";

    data += determineEnemyName();

    for (int i = 0; i < turns.length; i++) {
      data += "```╔══════════════════╗\n";
      data += "║      Turn " + (i + 1).toString() + "      ║\n";
      data += "╚══════════════════╝```\n";

      for (int j = 0; j < turns[i].characters.length; j++) {
        data += determineType(i, j);
        data += " :**__ (**" + calculateSpeed(i, j) + "** SPD)\n";
        data += determineHP(i, j);
        data += determineSets(i, j);
        data += determineArtifact(i, j);
        data += determineComment(i, j);

        if (j < (turns[i].characters.length - 1)) {
          data += "\n";
        }
      }
    }

    return data;
  }
}
