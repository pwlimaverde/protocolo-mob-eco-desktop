import 'package:flutter/material.dart';

class BotaoDownloadXlsx extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  final bool ativo;
  const BotaoDownloadXlsx({
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
        ativo ? Icons.download : Icons.download_for_offline,
        color: ativo ? Colors.lightBlue : Colors.grey,
        size: size,
      ),
      onPressed: ativo ? onPressed : null,
    );
  }
}
