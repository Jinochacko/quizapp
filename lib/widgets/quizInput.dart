import 'package:flutter/material.dart';

class QuizInputHandle extends StatelessWidget {
  final String result;
  final String label;
  final bool hasDropdownArrow;
  final VoidCallback callback;

  const QuizInputHandle(
      {required String this.label, String this.result = "", bool this.hasDropdownArrow = true, required VoidCallback this.callback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.transparent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: Color.fromRGBO(110, 110, 115, 1)),
                  ),
                  result != ""
                      ? Text(
                          result,
                          style: TextStyle(color: Colors.white),
                        )
                      : SizedBox(),
                ],
              ),
              hasDropdownArrow ? Icon(
                Icons.arrow_drop_down,
                color: Color.fromRGBO(110, 110, 115, 1),
              ): SizedBox()
            ],
          ),
          onPressed: callback),
      height: 48,
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromRGBO(230, 109, 193, 1)),
            left: BorderSide(color: Color.fromRGBO(230, 109, 193, 1)),
            right: BorderSide(color: Color.fromRGBO(230, 109, 193, 1)),
            bottom: BorderSide(color: Color.fromRGBO(230, 109, 193, 1)),
          ),
          borderRadius: BorderRadius.all(Radius.elliptical(24, 24))),
    );
  }
}
