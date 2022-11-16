import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

mixin LoaderMixin on GetxController {
  void loaderListener({
    required RxBool statusLoad,
  }) {
    ever<bool>(
      statusLoad,
      (loading) {
        if (loading) {
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          Get.back();
        }
        if (!loading) {
          bool? dialogOpen = Get.isDialogOpen;
          if (dialogOpen != null && dialogOpen) {
            Navigator.pop(Get.context!);
          }
        }
      },
    );
  }
}
