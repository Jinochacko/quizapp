import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback callback;
  final bool isDisabled;
  final bool coloredButton;
  final bool blackButton;
  final bool hasPrevButton;

  const Footer({required String this.buttonLabel, required VoidCallback this.callback, bool this.hasPrevButton = false, bool this.isDisabled = false, bool this.blackButton = false, bool this.coloredButton = false, String backButton = "", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        hasPrevButton ? Expanded(child: FilledButton(
            onPressed: () => {
              Navigator.pop(context)
            },
            child: Text(
              "Prev".toUpperCase(),
              style: TextStyle(
                  color: Color.fromRGBO(174,174,178, 1),
                  fontWeight: FontWeight.bold
              ),
            ),
            style: FilledButton.styleFrom(
                backgroundColor: Color.fromRGBO(110,110,115, 1),
                minimumSize: const Size.fromHeight(50)),
          ),
        ): SizedBox(),
        SizedBox(width: hasPrevButton ? 20: 0,),
        Expanded(child: Opacity(
          opacity: isDisabled ? 0.15: 1,
          child: FilledButton(
            onPressed: isDisabled ? () => {}: callback,
            child: Text(
              buttonLabel.toUpperCase(),
              style: TextStyle(
                  color: blackButton ? Color.fromRGBO(110,110,115, 1): coloredButton ? Colors.white: Color.fromRGBO(29, 29, 31, 1),
                  fontWeight: FontWeight.bold
              ),
            ),
            style: FilledButton.styleFrom(
                backgroundColor: blackButton ? Color.fromRGBO(13, 13, 13, 1): coloredButton ? Color.fromRGBO(230, 109, 193, 1): Color.fromRGBO(237, 237, 237, 1),
                minimumSize: const Size.fromHeight(50)),
          ),
        ))
      ],
    ),
    );
  }
}
