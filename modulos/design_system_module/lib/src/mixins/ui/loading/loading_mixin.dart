import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

mixin LoadingMixin on GetxController {
  void loaingListener({
    required RxDouble loadingValue,
  }) {
    ever<double>(
      loadingValue,
      (loading) {
        _loadUi(loading);
      },
    );
  }
}

void _loadUi(double loading) {
  Get.back();
  if (loading > 0.0) {
    print("${loading * 100}%");
    Get.dialog(
      Align(
        alignment: Alignment.center,
        child: Card(
          child: SizedBox(
            width: 150,
            height: 150,
            child: CircularPercentIndicator(
              radius: 50.0,
              lineWidth: 13.0,
              animation: true,
              percent: loading,
              center: Text(
                "${loading < 0.05 ? 0 : loading * 100}%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: const Text(
                "Aguarde...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  } else {
    Get.back();
  }
  // if (!loading) {
  //   bool? dialogOpen = Get.isDialogOpen;
  //   if (dialogOpen != null && dialogOpen) {
  //     Navigator.pop(Get.context!);
  //   }
  // }
}
