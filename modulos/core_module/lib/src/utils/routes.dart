enum Routes {
  initial(caminho: "/"),
  // home,
  splash(caminho: "/splash"),
  uploadRemessa(caminho: "/uploadremessa"),
  remessas(caminho: "/remessas");

  final String caminho;
  const Routes({required this.caminho});
}
