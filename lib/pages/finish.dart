import 'package:flutter/material.dart';
import 'package:quiz/widgets/footer.dart';
import '../main.dart';
import '../widgets/progress.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});

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
    return Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
        child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Progress(hasDot: false,),
                SizedBox(height: 50),
                Text(
                  "Congratulations",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 20),
                Text(
                  "Quiz 100% completed",
                  style: TextStyle(
                      color: Color.fromRGBO(230, 109, 193, 1), fontSize: 13),
                )
              ]),
            ),
            ),
            Footer(
              buttonLabel: "Re-start",
              callback: () => {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              QuizApp()), (Route<dynamic> route) => false)
              },
            )
          ],
        ));
  }
}
