import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/pages/numberInput.dart';
import 'package:quiz/widgets/footer.dart';
import 'package:quiz/widgets/progressRow.dart';
import 'package:quiz/widgets/quizInput.dart';

import '../provider/quizProvider.dart';
import 'countryDetails.dart';

class NumberDetailsPage extends StatelessWidget {
  const NumberDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context)),
        actions: [
          Center(
              child: Padding(
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.grey),
            ),
            padding: EdgeInsets.all(20),
          ))
        ],
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(color: Colors.black),
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 42),
        child: NumberStateful(),
      ),
    );
  }
}

class NumberStateful extends StatefulWidget {
  const NumberStateful({super.key});

  @override
  State<NumberStateful> createState() => _NumberStatefulState();
}

class _NumberStatefulState extends State<NumberStateful> {

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              ProgressRow(),
              SizedBox(height: 50),
              QuizInputHandle(
                label: "Number",
                result: quiz.documentNumber,
                hasDropdownArrow: false,
                callback: () => {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NumberInputPage())),},
              )
            ],
          ),
          Footer(
              buttonLabel: "Next",
              hasPrevButton: true,
              coloredButton: true,
              isDisabled: quiz.documentNumber == "" ? true: false,
            callback: () => {

              if(quiz.country.name == ""){
                Provider.of<QuizProvider>(context,
                    listen: false)
                    .setPercentageStep(2)
              },
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => CountryDetailsPage())),},
              )
        ],
      ),
    );
  }
}
