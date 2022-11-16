import 'package:flutter/material.dart';

class RightWidget extends StatelessWidget {
  final double menuWidth;
  final bool showMenu;
  final double sizeW;
  final Widget widget;

  const RightWidget({
    Key? key,
    required this.menuWidth,
    required this.showMenu,
    required this.sizeW,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: widget,
        ),
        Container(
          width: showMenu ? sizeW : sizeW - menuWidth,
          color: Colors.red[200],
        ),
      ],
    );
  }
}
