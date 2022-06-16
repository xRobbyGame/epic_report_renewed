// ignore_for_file: deprecated_member_use, prefer_const_constructors, unnecessary_new, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/ReportViewController.dart';
import 'package:flutter_application_1/utils/appColors.dart';

import '../utils/appFunctions.dart';

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

  //################# Build of page #################
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //################# Appbar #################
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Epic Report'),
            GestureDetector(
              child: Text(
                'All the data you need to win',
                style: TextStyle(fontSize: 9, color: AppColors.light_grey),
              ),
            )
          ],
        ),
        leading: Icon(Icons.auto_awesome),
        backgroundColor: Colors.black,
        actions: [
          //Infos button
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => new AlertDialog(
                    backgroundColor: AppColors.dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black, width: 2),
                    ),
                    title: Center(
                        child: Text('Information',
                            style: TextStyle(color: Colors.white))),
                    content: Column(mainAxisSize: MainAxisSize.min, children: [
                      Center(
                          child: Text('Version : 1.1.2',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.light_grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(height: 10),
                      Center(
                          child: Text(
                              'Epic Report is a guild war report generator for Epic Seven.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.light_grey, fontSize: 13))),
                    ]),
                  ),
                );
              },
              child: Icon(Icons.info_rounded)),
          //Reset button
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => new AlertDialog(
                    backgroundColor: AppColors.dark,
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
                            child: Text('All data will be reset.',
                                style: TextStyle(color: AppColors.light_grey))),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            new FlatButton(
                              onPressed: () {
                                setState(() {
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
      //################# Body of the page #################
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: AppColors.much_darker,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: AppColors.dark,
                    spreadRadius: 5,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ListView(
                children: [
                  //################# Enemy name #################
                  Container(
                    width: 200.0,
                    margin: const EdgeInsets.all(20.00),
                    child: Row(
                      children: [
                        Flexible(
                            child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9a-zA-Z]")),
                          ],
                          maxLength: 15,
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          controller: controller.enemyName,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.darker,
                            labelText: 'Enemy name',
                            labelStyle: TextStyle(color: AppColors.light_grey),
                            counterText: "",
                          ),
                        )),
                      ],
                    ),
                  ),
                  //################# Turns #################
                  for (var i = 0; i < 2; i++)
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side:
                              BorderSide(color: AppColors.light_grey, width: 2),
                        ),
                        color: AppColors.much_darker,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.00, vertical: 15.00),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15.00),
                          child: Column(children: [
                            //################# Player speed #################
                            InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                      color: controller.turns[i].yourSpeedColor,
                                      width: 2),
                                ),
                                color: AppColors.much_darker,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 50.00, vertical: 10.00),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text('Your speed',
                                          style: TextStyle(
                                              color: AppColors.light_grey)),
                                      subtitle: Text(
                                          controller.turns[i]
                                              .speedFirstCharacter.text,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      leading:
                                          controller.turns[i].yourSpeedIcon,
                                    ),
                                  ],
                                ),
                              ),
                              //Popup
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      new AlertDialog(
                                    backgroundColor: AppColors.darker,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Colors.black, width: 2),
                                    ),
                                    title: Center(
                                        child: Text('Your first character',
                                            style: TextStyle(
                                                color: Colors.white))),
                                    content: new GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      },
                                      child: new Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                              child: TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            maxLength: 3,
                                            controller: controller
                                                .turns[i].speedFirstCharacter,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              filled: true,
                                              fillColor: AppColors.dark,
                                              labelText: 'Speed',
                                              labelStyle: TextStyle(
                                                  color: AppColors.light_grey),
                                              counterText: "",
                                            ),
                                          )),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                  child: TextField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                maxLength: 2,
                                                controller: controller
                                                    .turns[i].crDepush,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 242, 90, 90)),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 53, 53, 53),
                                                  labelText: 'Depush',
                                                  labelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 242, 90, 90)),
                                                  counterText: "",
                                                ),
                                              )),
                                              SizedBox(width: 5),
                                              SizedBox(
                                                width: 30,
                                                child: Center(
                                                  child: Text(
                                                    'CR%',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .light_grey,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Flexible(
                                                  child: TextField(
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                maxLength: 2,
                                                controller:
                                                    controller.turns[i].crPush,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 147, 255, 149)),
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  filled: true,
                                                  fillColor: Color.fromARGB(
                                                      255, 53, 53, 53),
                                                  labelText: 'Push',
                                                  labelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 147, 255, 149)),
                                                  counterText: "",
                                                ),
                                              )),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                            child: Text(
                                                'Your information is necessary to estimate opponent\'s speed',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: AppColors.light_grey,
                                                    fontSize: 13)),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              new FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    controller.turns[i]
                                                        .speedFirstCharacter;
                                                    if (controller
                                                            .turns[i]
                                                            .speedFirstCharacter
                                                            .text !=
                                                        "") {
                                                      controller.turns[i]
                                                              .yourSpeedColor =
                                                          Colors.blue;
                                                      controller.turns[i]
                                                              .yourSpeedIcon =
                                                          Icon(
                                                              Icons
                                                                  .check_rounded,
                                                              color:
                                                                  Colors.blue);
                                                    } else {
                                                      controller.turns[i]
                                                              .yourSpeedColor =
                                                          Colors.red;
                                                      controller.turns[i]
                                                              .yourSpeedIcon =
                                                          Icon(
                                                              Icons
                                                                  .highlight_remove_rounded,
                                                              color:
                                                                  Colors.red);
                                                    }
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                textColor: Theme.of(context)
                                                    .primaryColor,
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Center(
                                child: Text(
                              'Turn ' + (i + 1).toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                            //Calling enemies
                            character(i, 0),
                            character(i, 1),
                            character(i, 2),
                          ]),
                        )),
                ],
              ),
            ),
          ),
        ),
      ),
      //################# Navbar #################
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(color: AppColors.much_darker, height: 45.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Copy report
          share_data = controller.processData();
          Clipboard.setData(new ClipboardData(text: share_data)).then((_) {
            //Message when copied
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: SizedBox(
                height: 40,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Report saved !',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'You can now paste it on Discord.',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]),
              ),
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ));
          });
        },
        tooltip: 'Share',
        child: const Text('Share'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  //Creation of an enemy
  InkWell character(int indexTurn, int indexChara) {
    //Default name
    final String defaultName = (_positionEnnemy[indexChara] + " character");
    if (controller.turns[indexTurn].characters[indexChara].cardName == "") {
      controller.turns[indexTurn].characters[indexChara].cardName = defaultName;
    }

    //Card creation
    return InkWell(
      //Visual
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 35.00, vertical: 10.00),
        decoration: BoxDecoration(
          color: AppColors.getColor(
              controller.turns[indexTurn].characters[indexChara].type.value),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            new BoxShadow(
              color: AppColors.getColor(controller
                  .turns[indexTurn].characters[indexChara].type.value),
              spreadRadius: 1,
              blurRadius: 3.0,
            ),
          ],
        ),
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
        //Popup
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              //Builder to callback popup information
              return StatefulBuilder(builder: (context, setStateEnemy) {
                return AlertDialog(
                  //################# Main widget #################
                  backgroundColor: AppColors.darker,
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
                  content: new GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        //Increasing popup width
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: new Column(
                          //################# Content #################
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //################# Name and type #################
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Name
                                Flexible(
                                    child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-zA-Z &.']"))
                                  ],
                                  maxLength: 20,
                                  keyboardType: TextInputType.text,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: controller.turns[indexTurn]
                                      .characters[indexChara].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.getColor(controller
                                          .turns[indexTurn]
                                          .characters[indexChara]
                                          .type
                                          .value)),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.dark,
                                    border: OutlineInputBorder(),
                                    labelText: 'Name',
                                    labelStyle:
                                        TextStyle(color: AppColors.light_grey),
                                    counterText: "",
                                  ),
                                )),
                                SizedBox(width: 10),
                                //Type
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Type :',
                                      style: TextStyle(
                                          color: AppColors.light_grey,
                                          fontSize: 12),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setStateEnemy(() {
                                            controller.turns[indexTurn]
                                                .characters[indexChara]
                                                .switchType();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.brightness_1,
                                          color: AppColors.getColor(controller
                                              .turns[indexTurn]
                                              .characters[indexChara]
                                              .type
                                              .value),
                                        )),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            //################# Artifact #################
                            Flexible(
                                child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z &.'\"()]"))
                              ],
                              maxLength: 20,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              controller: controller.turns[indexTurn]
                                  .characters[indexChara].artifact,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: AppColors.dark,
                                labelText: 'Artifact',
                                labelStyle:
                                    TextStyle(color: AppColors.light_grey),
                                counterText: "",
                              ),
                            )),
                            SizedBox(height: 10),
                            //################# HP #################
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoSwitch(
                                  activeColor: AppColors.getColor('Ice'),
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
                                        textColor:
                                            Theme.of(context).primaryColor,
                                        child: const Text('-'),
                                      ),
                                      SizedBox(width: 5),
                                      SizedBox(
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                              AppFunctions.convertNumber(
                                                      controller
                                                          .turns[indexTurn]
                                                          .characters[
                                                              indexChara]
                                                          .hp
                                                          .value) +
                                                  ' HP',
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
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
                                        textColor:
                                            Theme.of(context).primaryColor,
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
                            //################# Enemy CR #################
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
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
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 2,
                                  controller: controller.turns[indexTurn]
                                      .characters[indexChara].cr,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: AppColors.dark,
                                    labelText: 'CR%',
                                    labelStyle:
                                        TextStyle(color: AppColors.light_grey),
                                    counterText: "",
                                  ),
                                )),
                                SizedBox(width: 5),
                                Flexible(
                                    child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 2,
                                  controller: controller.turns[indexTurn]
                                      .characters[indexChara].crPush,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 147, 255, 149)),
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
                            SizedBox(height: 5),
                            //################# Enemy has outspeed #################
                            Center(
                              child: InkWell(
                                child: SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      controller
                                          .turns[indexTurn]
                                          .characters[indexChara]
                                          .iconHasEnemyOutsped,
                                      SizedBox(width: 10),
                                      Text("Enemy has outsped",
                                          style: TextStyle(
                                              color: controller
                                                  .turns[indexTurn]
                                                  .characters[indexChara]
                                                  .colorHasEnemyOutsped)),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setStateEnemy(() {
                                    controller
                                        .turns[indexTurn].characters[indexChara]
                                        .updateEnemyHasOutsped();
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 5),
                            //################# Sets #################
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sets :',
                                    style:
                                        TextStyle(color: AppColors.light_grey),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      height: 40,
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: AppColors.dark,
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
                                              items: (sets.map<
                                                      DropdownMenuItem<String>>(
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
                                  Center(
                                    child: InkWell(
                                      child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .colorHasImmunityBox,
                                            border: Border.all()),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Immunity",
                                                style: TextStyle(
                                                    color: controller
                                                        .turns[indexTurn]
                                                        .characters[indexChara]
                                                        .colorHasImmunityText)),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        setStateEnemy(() {
                                          controller.turns[indexTurn]
                                              .characters[indexChara]
                                              .updateImmunity();
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 10),
                            //################# Additional infos #################
                            Flexible(
                                child: TextField(
                              maxLength: 50,
                              maxLines: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[^*-_`]"))
                              ],
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              controller: controller.turns[indexTurn]
                                  .characters[indexChara].additionalInfos,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: AppColors.dark,
                                labelText: 'Additional infos',
                                labelStyle:
                                    TextStyle(color: AppColors.light_grey),
                                counterStyle:
                                    TextStyle(color: AppColors.light_grey),
                              ),
                            )),
                            SizedBox(height: 10),
                            //################# Close button #################
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
                                        controller
                                                .turns[indexTurn]
                                                .characters[indexChara]
                                                .cardName =
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
                  ),
                );
              });
            }).then((value) => setState(() {}));
      },
    );
  }
}
