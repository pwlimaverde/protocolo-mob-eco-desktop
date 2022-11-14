import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';
import '../home_controller.dart';
import 'widgets/bodyhome/bodyhome_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return designSystemController.scaffold(
      body: BodyHomeWidget(),
      page: 0,
      context: context,
    );
  }
}
