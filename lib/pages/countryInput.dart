import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/quizProvider.dart';
import 'package:quiz/widgets/footer.dart';

import '../models/countryItem.dart';

class CountryInputPage extends StatelessWidget {
  const CountryInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CountryInputStateful(),
    );
  }
}

class CountryInputStateful extends StatefulWidget {
  const CountryInputStateful({super.key});

  @override
  State<CountryInputStateful> createState() => _CountryInputStatefulState();
}

class _CountryInputStatefulState extends State<CountryInputStateful> {
  final _numberInputController = TextEditingController();

  List<CountryItem> _list = [];

  @override
  void initState() {
    super.initState();
    _list = Provider.of<QuizProvider>(context, listen: false).countries;
  }

  void _filter(String val) {
    final fullList = Provider.of<QuizProvider>(context, listen: false).countries;
    List<CountryItem> filtered = [];
    fullList.forEach((country) {
      if(country.name.toLowerCase().contains(val.toLowerCase())){
        filtered.add(country);
      }
    });
    setState(() {
      _list = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        return Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(color: Color.fromRGBO(29, 29, 31, 0.95)),
            padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 42),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(13, 13, 13, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(30, 30)),
                        border: Border.all(
                            width: 1, color: Color.fromRGBO(51, 51, 51, 1))),
                    child: Column(children: [
                      Text(
                        "Country",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(248, 100, 197, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      TextField(
                        onChanged: (value) => {
                          _filter(value)
                        },
                        controller: _numberInputController,
                        style: TextStyle(height: 1),
                        decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(174, 174, 178, 1),
                            fontSize: 13),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(230, 109, 193, 1)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.0,
                                  color: Color.fromRGBO(230, 109, 193, 1)),
                            ),
                            prefixIcon: Icon(Icons.search, size: 12,
                                color: Color.fromRGBO(51, 51, 51, 1)),
                            suffixIcon: _numberInputController.text != ""
                                ? IconButton(
                              color: Color.fromRGBO(230, 109, 193, 1),
                              icon: Icon(Icons.cancel,size: 16),
                              onPressed: () {
                                _numberInputController.clear();
                                _filter("");
                              },
                            )
                                : SizedBox(),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0,
                                    color: Color.fromRGBO(230, 109, 193, 1)),
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(24, 24)))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0, top: 8, right: 0, bottom: 8),
                            child: Text(
                              "Countries",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color.fromRGBO(174, 174, 178, 1),
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: _list.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(
                                      left: 0, top: 8, right: 8, bottom: 0),
                                  title: Text(
                                    _list[index].name +
                                        " (" +
                                        _list[index].code +
                                        ")",
                                    style: TextStyle(
                                        color: Color.fromRGBO(110, 110, 115, 1),
                                        fontSize: 13),
                                  ),
                                  trailing: _list[index].code ==
                                          quiz.country.code
                                      ? Icon(
                                          Icons.flag_circle,
                                          size: 16,
                                          color:
                                              Color.fromRGBO(248, 100, 197, 1),
                                        )
                                      : SizedBox(),
                                  onTap: () => {
                                    Provider.of<QuizProvider>(context,
                                            listen: false)
                                        .setCountry(_list[index]),
                                    Navigator.pop(context)
                                  },
                                ),
                              );
                            }),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Footer(
                  buttonLabel: "Cancel",
                  blackButton: true,
                  callback: () => Navigator.pop(context),
                )
              ],
            ));
      },
    );
  }
}
