import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

class BodyHomeWidget2 extends StatelessWidget {
  const BodyHomeWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: coreModuleController.sizeH,
      child: Container(
        color: Colors.black12,
        child: const Center(
          child: Text(
            "Bem vindo.",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
