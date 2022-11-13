import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';
import 'service/storage/storage_service.dart';
import 'service/widgets_flutter_binding/widgets_flutter_binding_service.dart';

void initServices() async {
  await Future.wait([
    Get.putAsync<WidgetsBinding>(
      () => WidgetsFlutterBindingService().init(),
      permanent: true,
    ),
    Get.putAsync<GetStorage>(
      () => StorageService().init(),
      permanent: true,
    ),
  ]);
}
