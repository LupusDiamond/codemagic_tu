import 'package:flutter/material.dart';

import '../utils/questions.dart';
import '../utils/quiz.dart';
import '../UI/answer_button.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Column( // This is our main page
          children: <Widget>[
            new AnswerButton(true, () => print("You answered true")),
            new Material(
              color: Colors.white,
              child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 20.0),
                  child: new Center(
                    child: new Text("Statement 1: You are doing great!"),
                  )
              )
            ),
            new AnswerButton(false, () => print("You answered false"))
          ],
        )
      ],
    );
  }
}