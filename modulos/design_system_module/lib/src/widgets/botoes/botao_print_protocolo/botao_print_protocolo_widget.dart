import 'package:flutter/material.dart';

class BotaoPrintProtocolo extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  final bool ativo;
  const BotaoPrintProtocolo({
    Key? key,
    this.onPressed,
    required this.size,
    required this.ativo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      icon: Icon(
        ativo ? Icons.print : Icons.print_disabled,
        color: ativo ? Colors.green : Colors.grey,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}
