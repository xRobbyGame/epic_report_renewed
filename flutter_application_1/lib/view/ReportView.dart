// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_new

import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controllers/TurnController.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/ReportViewController.dart';
import 'package:flutter_application_1/utils/appColors.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  ReportViewController controller = Get.put(ReportViewController());
  AppColors appColors = new AppColors();
  String share_data = "";
  final List<String> _positionEnnemy = ['First', 'Second', 'Third'];
  Color yourSpeedColor = AppColors().getLightGrey();
  Icon yourSpeedIcon = Icon(Icons.border_color_rounded);

  String determineType(int indexTurn, int indexChara) {
    String data = "";

    switch (controller.turns[indexTurn].characters[indexChara].type.value) {
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
        (controller.turns[indexTurn].characters[indexChara].name.value.text !=
                ""
            ? controller.turns[indexTurn].characters[indexChara].name.value.text
            : "?");

    return data;
  }

  String determineEnemyName() {
    String data = "";

    if (controller.enemyName.value.text != "") {
      data += "__**" + controller.enemyName.value.text + " :**__\n\n";
    }

    return data;
  }

  String calculateSpeed(int indexTurn, int indexChara) {
    String finalResult = "";
    int result = 0;

    if (controller.speedFirstCharacter.text.isEmpty ||
        controller.turns[indexTurn].characters[indexChara].cr.value.text ==
            '') {
      finalResult = "?";
    } else {
      result = controller.calculteRealSpeed();
      int crChara = int.parse(
          controller.turns[indexTurn].characters[indexChara].cr.value.text);
      if (controller
              .turns[indexTurn].characters[indexChara].crPush.value.text !=
          '') {
        crChara += int.parse(controller
            .turns[indexTurn].characters[indexChara].crPush.value.text);
      }
      if (controller
              .turns[indexTurn].characters[indexChara].crDepush.value.text !=
          '') {
        crChara += int.parse(controller
            .turns[indexTurn].characters[indexChara].crDepush.value.text);
      }

      if (controller
          .turns[indexTurn].characters[indexChara].hasEnemyOutspeed.value) {
        crChara += 100;
      }

      result = (result.toDouble() * ((crChara) / 100)).toInt();

      finalResult += "~";

      if (result % 5 == 1) {
        result -= 1;
        finalResult += result.toString();
      } else if (result % 5 == 4) {
        result += 1;
        finalResult += result.toString();
      } else if (result % 5 != 0) {
        result -= result % 5;

        finalResult += result.toString();

        result += 5;

        finalResult += "-" + result.toString();
      } else {
        finalResult += result.toString();
      }
    }

    return finalResult;
  }

  String determineHP(int indexTurn, int indexChara) {
    String data = "> **";

    if (controller.turns[indexTurn].characters[indexChara].isHpEnabled.value) {
      data += convertNumber(
          controller.turns[indexTurn].characters[indexChara].hp.value);
    } else {
      data += "?";
    }
    data += "** HP\n";

    return data;
  }

  String determineSets(int indexTurn, int indexChara) {
    String data = "";

    List<String> sets = [];

    if ((controller.turns[indexTurn].characters[indexChara].hasImmunity.value ||
        controller.turns[indexTurn].characters[indexChara].set.value !=
            "None")) {
      data += "> ";
      if (controller
          .turns[indexTurn].characters[indexChara].hasImmunity.value) {
        sets.add(":muscle:");
      }
      switch (controller.turns[indexTurn].characters[indexChara].set.value) {
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

  String determineArtifact(int indexTurn, int indexChara) {
    String data = "> `";

    if (controller.turns[indexTurn].characters[indexChara].artifact.value.text
        .isNotEmpty) {
      data += controller
          .turns[indexTurn].characters[indexChara].artifact.value.text;
    } else {
      data += "?";
    }

    data += "`\n";

    return data;
  }

  String determineComment(int indexTurn, int indexChara) {
    String data = "";

    if (controller.turns[indexTurn].characters[indexChara].additionalInfos.value
        .text.isNotEmpty) {
      data += "> *" +
          controller.turns[indexTurn].characters[indexChara].additionalInfos
              .value.text +
          "*\n";
    }

    return data;
  }

  void processData() {
    String data = "";

    data += determineEnemyName();

    for (int i = 0; i < controller.turns.length; i++) {
      data += "```────────── T" + (i + 1).toString() + " ──────────```\n";

      for (int j = 0; j < controller.turns[i].characters.length; j++) {
        data += determineType(i, j);
        data += " :**__ (**" + calculateSpeed(i, j) + "** SPD)\n";
        data += determineHP(i, j);
        data += determineSets(i, j);
        data += determineArtifact(i, j);
        data += determineComment(i, j);

        if (j < (controller.turns[i].characters.length - 1)) {
          data += "\n";
        }
      }
    }

    share_data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epic Report'),
        leading: Icon(Icons.auto_awesome),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => new AlertDialog(
                    backgroundColor: appColors.getDarker(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black, width: 2),
                    ),
                    title: Center(
                        child: Text('Reset data',
                            style: TextStyle(color: Colors.white))),
                    content: new Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Text('All data will be reset',
                                style: TextStyle(
                                    color: appColors.getLightGrey()))),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new FlatButton(
                              onPressed: () {
                                setState(() {
                                  yourSpeedColor = appColors.getLightGrey();
                                  yourSpeedIcon =
                                      Icon(Icons.border_color_rounded);
                                  controller = new ReportViewController();
                                });
                                Navigator.of(context).pop();
                              },
                              textColor: Theme.of(context).primaryColor,
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Icon(Icons.autorenew))
        ],
      ),
      body: Center(
        child: Container(
          color: appColors.getDark(),
          child: ListView(
            children: [
              //################# Nom de l'adversaire #################
              Container(
                width: 200.0,
                margin: const EdgeInsets.all(20.00),
                child: Flexible(
                    child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                  ],
                  maxLength: 15,
                  autofocus: false,
                  controller: controller.enemyName,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: appColors.getDarker(),
                    labelText: 'Enemy name',
                    labelStyle: TextStyle(color: appColors.getLightGrey()),
                    counterText: "",
                  ),
                )),
              ),
              //################# Speed joueur #################
              InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: yourSpeedColor,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 50.00, vertical: 10.00),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Your speed'),
                        subtitle: Text(controller.speedFirstCharacter.text,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: yourSpeedIcon,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => new AlertDialog(
                      backgroundColor: appColors.getDarker(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      title: Center(
                          child: Text('Your first character',
                              style: TextStyle(color: Colors.white))),
                      content: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                              child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            maxLength: 3,
                            controller: controller.speedFirstCharacter,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Speed',
                              labelStyle:
                                  TextStyle(color: appColors.getLightGrey()),
                              counterText: "",
                            ),
                          )),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                maxLength: 2,
                                controller: controller.crDepush,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 242, 90, 90)),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 53, 53, 53),
                                  labelText: 'CR Depush',
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 242, 90, 90)),
                                  counterText: "",
                                ),
                              )),
                              SizedBox(width: 10),
                              Flexible(
                                  child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                maxLength: 2,
                                controller: controller.crPush,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 147, 255, 149)),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 53, 53, 53),
                                  labelText: 'CR Push',
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 147, 255, 149)),
                                  counterText: "",
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).then((value) => setState(() {
                        controller.speedFirstCharacter;
                        if (controller.speedFirstCharacter.text != "") {
                          yourSpeedColor = Colors.blue;
                          yourSpeedIcon = Icon(Icons.check_rounded);
                        } else {
                          yourSpeedColor = appColors.getLightGrey();
                          yourSpeedIcon = Icon(Icons.border_color_rounded);
                        }
                      }));
                },
              ),
              //################# Personnages ennemis #################
              turn(0),
              turn(1),
            ],
          ),
        ),
      ),
      //################# Menu navbar #################
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
            color: const Color.fromARGB(255, 27, 27, 27), height: 45.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          processData();
          Share.share(share_data);
        },
        tooltip: 'Share',
        child: const Text('Share'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //Création d'un tour
  Card turn(int indexTurn) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: appColors.getDarker(),
        margin: const EdgeInsets.symmetric(horizontal: 20.00, vertical: 15.00),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15.00),
          child: Column(children: [
            Center(
                child: Text(
              'Turn ' + (indexTurn + 1).toString(),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
            character(indexTurn, 0),
            character(indexTurn, 1),
            character(indexTurn, 2),
          ]),
        ));
  }

  //Création d'un personnage ennemi
  InkWell character(int indexTurn, int indexChara) {
    final String defaultName = (_positionEnnemy[indexChara] + " character");
    if (controller.turns[indexTurn].characters[indexChara].cardName == "") {
      controller.turns[indexTurn].characters[indexChara].cardName = defaultName;
    }
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: appColors.getColor(
            controller.turns[indexTurn].characters[indexChara].type.value),
        margin: const EdgeInsets.symmetric(horizontal: 35.00, vertical: 10.00),
        child: Column(
          children: [
            ListTile(
              title: Text(
                  controller.turns[indexTurn].characters[indexChara].cardName),
              subtitle: Text(
                  controller.turns[indexTurn].characters[indexChara].cardInfos),
              leading: Icon(Icons.border_color_rounded),
            )
          ],
        ),
      ),
      onTap: () {
        var sets = ['None', 'Counter', 'Lifesteal', 'Injury'];

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setStateEnemy) {
                return AlertDialog(
                  backgroundColor: appColors.getDarker(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  insetPadding: EdgeInsets.all(15.0),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.00, vertical: 10.0),
                  title: Center(
                      child: Text('Enemy info',
                          style: TextStyle(color: Colors.white))),
                  content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z ]"))
                                ],
                                maxLength: 20,
                                controller: controller.turns[indexTurn]
                                    .characters[indexChara].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: appColors.getColor(controller
                                        .turns[indexTurn]
                                        .characters[indexChara]
                                        .type
                                        .value)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: appColors.getDark(),
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      color: appColors.getLightGrey()),
                                  counterText: "",
                                ),
                              )),
                              IconButton(
                                  onPressed: () {
                                    setStateEnemy(() {
                                      if (controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .type
                                              .value ==
                                          'None') {
                                        controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .type
                                            .value = 'Fire';
                                      } else if (controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .type
                                              .value ==
                                          'Fire') {
                                        controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .type
                                            .value = 'Ice';
                                      } else if (controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .type
                                              .value ==
                                          'Ice') {
                                        controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .type
                                            .value = 'Earth';
                                      } else if (controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .type
                                              .value ==
                                          'Earth') {
                                        controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .type
                                            .value = 'Dark';
                                      } else if (controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .type
                                              .value ==
                                          'Dark') {
                                        controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .type
                                            .value = 'Light';
                                      } else if (controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .type
                                              .value ==
                                          'Light') {
                                        controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .type
                                            .value = 'None';
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.brightness_1,
                                    color: appColors.getColor(controller
                                        .turns[indexTurn]
                                        .characters[indexChara]
                                        .type
                                        .value),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Flexible(
                              child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z ]"))
                            ],
                            maxLength: 20,
                            controller: controller.turns[indexTurn]
                                .characters[indexChara].artifact,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: appColors.getDark(),
                              labelText: 'Artifact',
                              labelStyle:
                                  TextStyle(color: appColors.getLightGrey()),
                              counterText: "",
                            ),
                          )),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoSwitch(
                                activeColor: appColors.getColor('Ice'),
                                value: controller.turns[indexTurn]
                                    .characters[indexChara].isHpEnabled.value,
                                onChanged: (bool value) {
                                  setStateEnemy(() {
                                    controller
                                        .turns[indexTurn]
                                        .characters[indexChara]
                                        .isHpEnabled
                                        .value = value;
                                  });
                                },
                              ),
                              Visibility(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      minWidth: 50,
                                      onPressed: () {
                                        if (controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .hp
                                                .value >
                                            5000) {
                                          setStateEnemy(() {
                                            controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .hp
                                                .value -= 1000;
                                          });
                                        }
                                      },
                                      textColor: Theme.of(context).primaryColor,
                                      child: const Text('-'),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                        convertNumber(controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .hp
                                                .value) +
                                            ' HP',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                    SizedBox(width: 5),
                                    new FlatButton(
                                      minWidth: 50,
                                      onPressed: () {
                                        if (controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .hp
                                                .value <
                                            50000) {
                                          setStateEnemy(() {
                                            controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .hp
                                                .value += 1000;
                                          });
                                        }
                                      },
                                      textColor: Theme.of(context).primaryColor,
                                      child: const Text('+'),
                                    ),
                                  ],
                                ),
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: controller.turns[indexTurn]
                                    .characters[indexChara].isHpEnabled.value,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                maxLength: 2,
                                controller: controller.turns[indexTurn]
                                    .characters[indexChara].crDepush,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 242, 90, 90)),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 53, 53, 53),
                                  labelText: 'Depush',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 242, 90, 90),
                                  ),
                                  counterText: "",
                                ),
                              )),
                              SizedBox(width: 5),
                              Flexible(
                                  child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                maxLength: 2,
                                controller: controller
                                    .turns[indexTurn].characters[indexChara].cr,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: appColors.getDark(),
                                  labelText: 'CR%',
                                  labelStyle: TextStyle(
                                      color: appColors.getLightGrey()),
                                  counterText: "",
                                ),
                              )),
                              SizedBox(width: 5),
                              Flexible(
                                  child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                                maxLength: 2,
                                controller: controller.turns[indexTurn]
                                    .characters[indexChara].crPush,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 147, 255, 149)),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 53, 53, 53),
                                  labelText: 'Push',
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 147, 255, 149)),
                                  counterText: "",
                                ),
                              )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: controller
                                    .turns[indexTurn]
                                    .characters[indexChara]
                                    .hasEnemyOutspeed
                                    .value,
                                onChanged: (newValue) {
                                  setStateEnemy(() {
                                    controller
                                        .turns[indexTurn]
                                        .characters[indexChara]
                                        .hasEnemyOutspeed
                                        .value = newValue!;
                                  });
                                },
                              ),
                              Text("Ennemi has outspeed",
                                  style: TextStyle(
                                      color: appColors.getLightGrey())),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sets :',
                                  style: TextStyle(
                                      color: appColors.getLightGrey()),
                                ),
                                SizedBox(width: 5),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: appColors.getDark(),
                                        border: Border.all()),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            value: controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .set
                                                .value,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            dropdownColor: Colors.black,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: (sets
                                                .map<DropdownMenuItem<String>>(
                                                    (String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items));
                                            })).toList(),
                                            onChanged: (String? newValue) {
                                              setStateEnemy(() {
                                                controller
                                                    .turns[indexTurn]
                                                    .characters[indexChara]
                                                    .set
                                                    .value = newValue!;
                                              });
                                            }))),
                                SizedBox(width: 5),
                                Checkbox(
                                  value: controller.turns[indexTurn]
                                      .characters[indexChara].hasImmunity.value,
                                  onChanged: (newValue) {
                                    setStateEnemy(() {
                                      controller
                                          .turns[indexTurn]
                                          .characters[indexChara]
                                          .hasImmunity
                                          .value = newValue!;
                                    });
                                  },
                                ),
                                Text("Immunity",
                                    style: TextStyle(
                                        color: appColors.getLightGrey())),
                              ]),
                          SizedBox(height: 10),
                          Flexible(
                              child: TextField(
                            maxLength: 50,
                            maxLines: 1,
                            controller: controller.turns[indexTurn]
                                .characters[indexChara].additionalInfos,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: appColors.getDark(),
                              labelText: 'Additional infos',
                              labelStyle:
                                  TextStyle(color: appColors.getLightGrey()),
                            ),
                          )),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new FlatButton(
                                onPressed: () {
                                  setStateEnemy(() {
                                    if (controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .name
                                            .value
                                            .text !=
                                        '') {
                                      controller.turns[indexTurn]
                                              .characters[indexChara].cardName =
                                          controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .name
                                              .value
                                              .text;
                                    } else {
                                      controller
                                          .turns[indexTurn]
                                          .characters[indexChara]
                                          .cardName = defaultName;
                                    }

                                    String cardInfos = "";
                                    if (controller
                                        .turns[indexTurn]
                                        .characters[indexChara]
                                        .isHpEnabled
                                        .value) {
                                      cardInfos += ((controller
                                                  .turns[indexTurn]
                                                  .characters[indexChara]
                                                  .hp
                                                  .value)
                                              .toString()
                                              .substring(
                                                  0,
                                                  controller
                                                          .turns[indexTurn]
                                                          .characters[
                                                              indexChara]
                                                          .hp
                                                          .value
                                                          .toString()
                                                          .length -
                                                      3)) +
                                          "K | ";
                                    }

                                    if (controller
                                            .turns[indexTurn]
                                            .characters[indexChara]
                                            .artifact
                                            .value
                                            .text !=
                                        '') {
                                      cardInfos += controller
                                          .turns[indexTurn]
                                          .characters[indexChara]
                                          .artifact
                                          .value
                                          .text;
                                    } else {
                                      cardInfos += '?';
                                    }
                                    controller
                                        .turns[indexTurn]
                                        .characters[indexChara]
                                        .cardInfos = cardInfos;
                                  });
                                  Navigator.of(context).pop();
                                },
                                textColor: Theme.of(context).primaryColor,
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            }).then((value) => setState(() {}));
      },
    );
  }

  //Converti un int en string à afficher
  String convertNumber(int number) {
    String convertedNumber = "";

    convertedNumber +=
        number.toString().substring(0, number.toString().length - 3);
    convertedNumber += " 000";

    return convertedNumber;
  }
}
