import 'package:flutter/material.dart';

class BotaoAnalisePdf extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  final double height;
  final double width;
  final bool ativo;
  const BotaoAnalisePdf({
    Key? key,
    this.onPressed,
    required this.size,
    required this.height,
    required this.width,
    required this.ativo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      alignment: Alignment.center,
      icon: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              ativo ? Icons.check : Icons.analytics,
              color: ativo ? Colors.green : Colors.grey,
              size: size,
            ),
            const Text(
              "Analise",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
