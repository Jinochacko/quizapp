import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/quizProvider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Position {
  final double x;
  final double y;

  Position(this.x, this.y);
}

class Progress extends StatelessWidget {
  final bool hasDot;
  final double stepPercentage = 33.33;
  const Progress({super.key, this.hasDot = true });

  Position getPosition(int step){
    if(step == 2){
      return Position(
          17,
          15
      );
    }
    if(step == 1){
      return Position(
          90,
          195
      );
    }
    return Position(
      180,
      15
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, quiz, child) => new Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 10, top: 0,right: 0,bottom: 0),child:
        CircularStepProgressIndicator(
          totalSteps: 3,
          currentStep: quiz.percentageStep,
          width: 190,
          height: 190,
          selectedColor: Color.fromRGBO(230, 109, 193, 1),
          unselectedColor: Color.fromRGBO(51, 51, 51, 1),
          child: Center(
            child: Text(
              quiz.percentageStep == 3 ? "100%": (stepPercentage * quiz.percentageStep).floor().toString()+"%",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
        ),
        Positioned(
          top: -4,
          left: 8,
          child: CircularStepProgressIndicator(
            totalSteps: 100,
            currentStep: (stepPercentage * quiz.percentageStep).round(),
            stepSize: 20,
            selectedColor: Color.fromRGBO(230, 109, 193, 1),
            unselectedColor: Color.fromRGBO(110, 110, 115, 1),
            padding: 0,
            width: 170,
            height: 170,
            selectedStepSize: 20,
            roundedCap: (_, __) => true,
          ),
        ),
        hasDot || (hasDot && quiz.percentageStep != 3)
            ? Positioned(
            left: getPosition(quiz.percentageStep).x,
            top: getPosition(quiz.percentageStep).y,
            child: Icon(
              Icons.fiber_manual_record,
              color: Color.fromRGBO(230, 109, 193, 1),
              size: 12,
            )
        )
            : SizedBox()
      ],
    ));
  }
}
