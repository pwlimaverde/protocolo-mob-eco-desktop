enum Routes {
  initial(caminho: "/"),
  // home,
  // home(caminho: "/home"),
  uploadRemessa(caminho: "/uploadremessa"),
  remessas(caminho: "/remessas");

  final String caminho;
  const Routes({required this.caminho});
}
