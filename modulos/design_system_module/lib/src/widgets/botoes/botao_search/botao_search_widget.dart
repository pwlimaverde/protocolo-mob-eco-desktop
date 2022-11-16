import 'package:flutter/material.dart';

class BotaoSearch extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  const BotaoSearch({
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
        Icons.search,
        color: Colors.white,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}