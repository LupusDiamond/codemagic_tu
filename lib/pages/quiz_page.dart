import 'package:flutter/material.dart';
import 'package:quiz/UI/question_text.dart';

import '../utils/questions.dart';
import '../utils/quiz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("An octopus has three hearts", true),
    new Question("Going out with wet hair increases your chances of catching a cold", true),
    new Question("Black holes aren't black", true),
    new Question("Bananas grow on trees", false),
    new Question("The Great Wall of China can be seen with the unaided eye from space", false),
    new Question("Sugar makes children hypier", false),
    new Question("Oxford University is older than the Aztec Empire", true),
    new Question("Chewing gum takes seven years for a person to digest", false),
    new Question("Carrots help you see in the dark", false),
    new Question("Russia has a larger surface area than Pluto", true),
    new Question("For every human on Earth there are 1.6 million ants", true),
    new Question("It rains diamonds on Saturn and Jupiter", true),
    new Question("Chocolate chip cookies have been around longer than Oreos.", false),
    new Question("Tattoo ink comes from various fruit juices.", false)
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // This is our main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay(
          isCorrect,
          () {
            if (quiz.length == questionNumber) {
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
              return;
            }
            currentQuestion = quiz.nextQuestion;
            this.setState(() {
              overlayShouldBeVisible = false;
            });
            questionText = currentQuestion.question;
            questionNumber = quiz.questionNumber;
          }
        ) : new Container()
      ],
    );
  }
}