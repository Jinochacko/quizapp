import 'dart:math';

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
  const Progress({super.key, this.hasDot = true});

  Position getPosition(int step, int totalQns, double radius) {
    double distanceToDotFromCenter = radius + 15;
    double angleStep = pi / totalQns;
    double angle = 2 * angleStep;
    double angleToCalculate = step * angle + angleStep;
    double x = radius + (distanceToDotFromCenter * sin(angleToCalculate));
    double y = radius - (distanceToDotFromCenter * cos(angleToCalculate));

    return Position(x, y);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double doughnutDiameter = screenWidth / 2 - 48;
    double progressDiameter = doughnutDiameter * 1.1;
    double doughnutStepSize = screenWidth * .05 < 20 ? 20 : screenWidth * .05;
    double progressStepSize =
        doughnutStepSize * .25 < 5 ? 5 : doughnutStepSize * .25;

    return Consumer<QuizProvider>(builder: (context, quiz, child) {
      Position coordinates = getPosition(quiz.percentageStep,
          quiz.totalNumberOfQuestions, progressDiameter / 2);

      return Container(
        child: new Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
              child: CircularStepProgressIndicator(
                totalSteps: quiz.totalNumberOfQuestions,
                currentStep: quiz.percentageStep,
                width: progressDiameter,
                height: progressDiameter,
                stepSize: progressStepSize,
                selectedColor: Color.fromRGBO(230, 109, 193, 1),
                unselectedColor: Color.fromRGBO(51, 51, 51, 1),
                child: Center(
                  child: Text(
                    quiz.percentageStep == quiz.totalNumberOfQuestions
                        ? "100%"
                        : ((100 / quiz.totalNumberOfQuestions) *
                                    quiz.percentageStep)
                                .floor()
                                .toString() +
                            "%",
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
                currentStep:
                    ((100 / quiz.totalNumberOfQuestions) * quiz.percentageStep)
                        .round(),
                stepSize: doughnutStepSize,
                selectedColor: Color.fromRGBO(230, 109, 193, 1),
                unselectedColor: Color.fromRGBO(110, 110, 115, 1),
                padding: 0,
                width: doughnutDiameter,
                height: doughnutDiameter,
                roundedCap: (_, __) => true,
              ),
            ),
            hasDot ||
                    (hasDot &&
                        quiz.percentageStep != quiz.totalNumberOfQuestions)
                ? Positioned(
                    left: coordinates.x,
                    top: coordinates.y,
                    child: Icon(
                      Icons.fiber_manual_record_rounded,
                      color: Color.fromRGBO(230, 109, 193, 1),
                      size: 12,
                    ))
                : SizedBox()
          ],
        ),
      );
    });
  }
}
