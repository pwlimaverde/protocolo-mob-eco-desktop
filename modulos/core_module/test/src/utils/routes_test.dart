import 'package:core_module/src/utils/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar a rota "/"', () {
    final rota = Routes.initial.caminho;

    if (kDebugMode) {
      print(rota);
    }
    expect(rota, isA<String>());
    expect(rota, equals("/"));
  });

  test('Deve retornar a rota "/splash"', () {
    final rota = Routes.splash.caminho;

    if (kDebugMode) {
      print(rota);
    }
    expect(rota, isA<String>());
    expect(rota, equals("/splash"));
  });
}
