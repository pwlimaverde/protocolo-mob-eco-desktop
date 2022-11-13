import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final List<Widget>? actions;

  const HeaderWidget({
    Key? key,
    required this.titulo,
    required this.subtitulo,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Center(
        child: Column(
          children: [
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              subtitulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }
}
