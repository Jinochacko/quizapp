import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/quizProvider.dart';
import 'package:quiz/pages/documentDetails.dart';
import 'package:quiz/widgets/progress.dart';
import 'package:quiz/widgets/footer.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: MaterialApp(
        title: 'Quiz App',
        theme: ThemeData.dark(),
        home: const HomePage(title: 'Information'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<QuizProvider>(context, listen: false).getCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        centerTitle: true,
        backgroundColor: Colors.black,
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
      body: Consumer<QuizProvider>(builder: (context, quiz, child){
        return Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(color: Colors.black),
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(children: [
                    Progress(hasDot: false,),
                    SizedBox(height: 50),
                    Text(
                      "Document Details",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Let’s complete the next few questions",
                      style: TextStyle(
                          color: Color.fromRGBO(230, 109, 193, 1), fontSize: 13),
                    )
                  ]),
                ),
                Footer(
                  buttonLabel: "Start",
                  callback: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DocumentDetailsPage())),
                )
              ],
            ));
      },),
    );
  }
}
