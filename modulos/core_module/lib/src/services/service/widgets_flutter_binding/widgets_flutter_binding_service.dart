import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

class WidgetsFlutterBindingService extends GetxService {
  Future<WidgetsBinding> init() async {
    final widgetsFlutterBinding = WidgetsFlutterBinding.ensureInitialized();
    return widgetsFlutterBinding;
  }
}
