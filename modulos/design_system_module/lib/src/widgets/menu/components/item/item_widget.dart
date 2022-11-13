import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final int page;
  final String? nav;
  final int indice;
  final Icon icon;
  final String title;

  const ItemWidget({
    Key? key,
    required this.page,
    this.nav,
    required this.indice,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: page == indice,
      leading: icon,
      title: Text(title),
      onTap: () {
        _nav();
      },
    );
  }

  void _nav() {
    page == indice
        ? null
        : nav != null
            ? Get.offAllNamed("$nav")
            : null;
    coreModuleController.pageAtual(indice);
    Get.find<GetStorage>().write("pageAtual", indice);
  }
}
