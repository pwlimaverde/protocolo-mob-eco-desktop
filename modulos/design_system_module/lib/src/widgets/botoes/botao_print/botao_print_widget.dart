import 'package:flutter/material.dart';

class BotaoPrint extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  final bool ativo;
  const BotaoPrint({
    Key? key,
    this.onPressed,
    required this.size,
    required this.ativo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.centerLeft,
      icon: Icon(
        ativo?Icons.print:Icons.print_disabled,
        color: Colors.white,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}