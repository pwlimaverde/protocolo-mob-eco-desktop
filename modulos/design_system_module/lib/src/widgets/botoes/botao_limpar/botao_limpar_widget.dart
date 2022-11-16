import 'package:flutter/material.dart';

class BotaoLimpar extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  const BotaoLimpar({
    Key? key,
    this.onPressed,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.centerLeft,
      icon: Icon(
        Icons.clear,
        color: Colors.red,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}
