import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/pages/numberDetails.dart';
import 'package:quiz/widgets/footer.dart';
import 'package:quiz/widgets/progressRow.dart';
import 'package:quiz/widgets/quizInput.dart';

import '../provider/quizProvider.dart';

class DocumentDetailsPage extends StatelessWidget {
  const DocumentDetailsPage({super.key});

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
        padding: EdgeInsets.all(30),
        child: DocumentStateful(),
      ),
    );
  }
}

class DocumentStateful extends StatefulWidget {
  const DocumentStateful({super.key});

  @override
  State<DocumentStateful> createState() => _DocumentStatefulState();
}

class _DocumentStatefulState extends State<DocumentStateful> {

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
                      label: "Type",
                      result: quiz.documentName,
                      callback: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          barrierColor: Color.fromRGBO(29, 29, 31, 0.95),
                          builder: (BuildContext context) {
                            return SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FilledButton(
                                        child: const Text('Passport'),
                                        onPressed: () => {
                                          Provider.of<QuizProvider>(context,
                                              listen: false)
                                              .setDocumentName("Passport"),
                                          Navigator.pop(context),
                                        },
                                        style: FilledButton.styleFrom(
                                            backgroundColor:
                                                Color.fromRGBO(13, 13, 13, 1),
                                            minimumSize:
                                                const Size.fromHeight(50)),

                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      FilledButton(
                                        child: const Text("National Card"),
                                        onPressed: () => {
                                          Provider.of<QuizProvider>(context,
                                              listen: false)
                                              .setDocumentName("National Card"),
                                          Navigator.pop(context),
                                        },
                                        style: FilledButton.styleFrom(
                                            backgroundColor:
                                                Color.fromRGBO(13, 13, 13, 1),
                                            minimumSize:
                                                const Size.fromHeight(50)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      FilledButton(
                                        child: Text(
                                          'Cancel'.toUpperCase(),
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  110, 110, 115, 1)),
                                        ),
                                        onPressed: () =>
                                            {Navigator.pop(context)},
                                        style: FilledButton.styleFrom(
                                            backgroundColor:
                                                Color.fromRGBO(13, 13, 13, 1),
                                            minimumSize:
                                                const Size.fromHeight(50)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                Footer(
                    buttonLabel: "Next",
                    coloredButton: true,
                    isDisabled: quiz.documentName == "" ? true: false,
                    callback: () => {
                      if(quiz.documentNumber == ""){
                        Provider.of<QuizProvider>(context,
                            listen: false)
                            .setPercentageStep(1)
                      },
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NumberDetailsPage()))})
              ],
            ));
  }
}
