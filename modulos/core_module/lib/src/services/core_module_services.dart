import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';
import 'service/database/database_service.dart';
import 'service/firebase/firebase_service.dart';
import 'service/storage/storage_service.dart';
import 'service/widgets_flutter_binding/widgets_flutter_binding_service.dart';

Future<void> initServices() async {
  await Future.wait([
    Get.putAsync<WidgetsBinding>(
      () => WidgetsFlutterBindingService().init(),
      permanent: true,
    ),
    Get.putAsync<GetStorage>(
      () => StorageService().init(),
      permanent: true,
    ),
    Get.putAsync<Store>(
      () => DatabaseService().init(),
      permanent: true,
    ),
    Get.putAsync<Firestore>(
      () => FirebaseService().init(),
      permanent: true,
    ),
  ]);
}
