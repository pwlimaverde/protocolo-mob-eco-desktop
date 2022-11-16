import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';
import '../splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
