import 'package:flutter/material.dart';

class BotaoUpload extends StatelessWidget {
  final void Function()? onPressed;
  final double size;
  const BotaoUpload({
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
        Icons.upload_file,
        color: Colors.white,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}
