import 'package:flutter/material.dart';

class BotaoLimparAnalise extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  final double height;
  final double width;
  final bool ativo;
  const BotaoLimparAnalise({
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
              ativo
                  ? Icons.cleaning_services
                  : Icons.cleaning_services_outlined,
              color: ativo ? Colors.amber : Colors.grey,
              size: size,
            ),
            const Text(
              "Limpar",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
