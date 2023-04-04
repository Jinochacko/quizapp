import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/quizProvider.dart';
import 'package:quiz/widgets/footer.dart';

class NumberInputPage extends StatelessWidget {
  const NumberInputPage({super.key});

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
        child: NumberInputStateful(),
      ),
    );
  }
}

class NumberInputStateful extends StatefulWidget {
  const NumberInputStateful({super.key});

  @override
  State<NumberInputStateful> createState() => _NumberInputStatefulState();
}

class _NumberInputStatefulState extends State<NumberInputStateful> {
  final _numberInputController = TextEditingController();
  String _result = "";
  bool _isDisabled = true;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final documentNum = Provider.of<QuizProvider>(context, listen: false).documentNumber;
      _numberInputController.text = documentNum;
      setState(() {
        _setResult(documentNum);
      });
    // });
  }

  void _setResult(String val) {
    setState(() {
      _result = val;
      if (val != "") {
        _isDisabled = false;
      } else {
        _isDisabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: [
            TextField(
              onChanged: (value) => _setResult(value),
              controller: _numberInputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Number",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0, color: Color.fromRGBO(230, 109, 193, 1)),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(24, 24))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0, color: Color.fromRGBO(230, 109, 193, 1)),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(24, 24))),
                  suffixIcon: _result != ""
                      ? IconButton(
                          color: Color.fromRGBO(230, 109, 193, 1),
                          icon: Icon(Icons.clear_rounded),
                          onPressed: () {
                            _numberInputController.clear();
                            setState(() {
                              _isDisabled = true;
                            });
                            Provider.of<QuizProvider>(context, listen: false)
                                .setDocumentNumber('');
                          },
                        )
                      : SizedBox(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.0, color: Color.fromRGBO(230, 109, 193, 1)),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(24, 24)))),
            ),
          ],
        ),
        Footer(
            buttonLabel: "Next",
            coloredButton: true,
            isDisabled: _isDisabled,
            callback: () => {
                  Provider.of<QuizProvider>(context, listen: false)
                      .setDocumentNumber(_numberInputController.text),
              Navigator.pop(context)
                })
      ],
    );
  }
}
