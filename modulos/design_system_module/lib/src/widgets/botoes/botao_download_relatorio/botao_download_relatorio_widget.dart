import 'package:flutter/material.dart';

class BotaoDownloadRelatorio extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  final double height;
  final double width;
  final bool ativo;
  final bool alerta;
  const BotaoDownloadRelatorio({
    Key? key,
    this.onPressed,
    required this.size,
    required this.height,
    required this.width,
    required this.ativo,
    required this.alerta,
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
              ativo
                  ? Icons.check
                  : alerta
                      ? Icons.error_outline_outlined
                      : Icons.error,
              color: ativo
                  ? Colors.green
                  : alerta
                      ? Colors.grey
                      : Colors.red,
              size: size,
            ),
            const Text(
              "Relatorio",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
