import 'package:flutter/material.dart';

class BotaoForm extends StatelessWidget {
  final Widget form;
  final Widget button;
  const BotaoForm({
    Key? key,
    required this.form,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0),
            width: 110,
            height: 30,
            child: form,
          ),
          Container(
            padding: const EdgeInsets.all(0),
            width: 20,
            height: 30,
            child: button,
          ),
        ],
      ),
    );
  }
}
