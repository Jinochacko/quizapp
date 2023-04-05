import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/pages/countryInput.dart';
import 'package:quiz/pages/numberInput.dart';
import 'package:quiz/widgets/footer.dart';
import 'package:quiz/widgets/progressRow.dart';
import 'package:quiz/widgets/quizInput.dart';
import 'package:quiz/provider/quizProvider.dart';

import 'finish.dart';

class CountryDetailsPage extends StatelessWidget {
  const CountryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),),
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
        child: CountryDetailsStateful(),
      ),
    );
  }
}

class CountryDetailsStateful extends StatefulWidget {
  const CountryDetailsStateful({super.key});

  @override
  State<CountryDetailsStateful> createState() => _CountryDetailsStatefulState();
}

class _CountryDetailsStatefulState extends State<CountryDetailsStateful> {

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
                label: "Country",
                result: quiz.country.name,
                callback: () => {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CountryInputPage())),},
              )
            ],
          ),
          Footer(
            buttonLabel: "Finish",
            hasPrevButton: true,
            coloredButton: true,
            isDisabled: quiz.country.name == "" ? true: false,
            callback: () => {
              Provider.of<QuizProvider>(context,
                  listen: false)
                  .setPercentageStep(3),
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => FinishPage())),},
          )
        ],
      ),
    );
  }
}
