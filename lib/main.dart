import 'dart:async';

import 'package:flutter/material.dart';
import 'containsQuestion.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Quizzler'),
          ),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.black,
        body: MainArea(),
      ),
    ),
  );
}

class MainArea extends StatefulWidget {
  @override
  _MainAreaState createState() => _MainAreaState();
}

class _MainAreaState extends State<MainArea> {
  ContainsQuestion containQuestion = ContainsQuestion();
  int questionNumber = 0;
  List<Icon> scoreKeeper = [];
  void checkanswer(bool a) {
    if (a == containQuestion.containsQuestion[questionNumber].answer)
      scoreKeeper.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    else
      scoreKeeper.add(
        Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
  }

  void func() {
    if (questionNumber < 2)
      questionNumber++;
    else {
      Timer(Duration(microseconds: 500), () {
        Alert(
                context: context,
                title: "Congrats",
                desc: "You have reached to the end of the questions")
            .show();
        questionNumber = 0;
        scoreKeeper = [];
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                containQuestion.containsQuestion[questionNumber].question,
                style: TextStyle(color: Colors.white, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    checkanswer(true);
                    func();
                  });
                },
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    checkanswer(false);
                    func();
                  });
                },
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ],
      ),
    );
  }
}
/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
