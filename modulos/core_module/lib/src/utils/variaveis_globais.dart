import 'package:dependencies_module/dependencies_module.dart';

final CoreModuleController coreModuleController = Get.find();
final Store dataBase = Get.find();
final Box<RemessaModel> dataBaseRemessa = Get.find();
final Box<BoletoModel> dataBaseBoleto = Get.find();
// final UploadRemessaController uploadRemessaController = Get.find();
// final DesignSystemController designSystemController = Get.find();
// final RemessasController remessasController = Get.find();

const double menuWidth = 200;
const double hederHeight = 60;
const double tabHeight = 40;
const String versaoAtual = "0.0.6";
const String imagemModeloProtocolo =
    "gs://protocolo-mob-ser.appspot.com/modelo/BASE-PROTOCOLO-MOB.jpeg";
final DateFormat dataFormatoDDMMYYYY = DateFormat('dd/MM/yyyy');
final DateFormat dataFormatoYYYYMMDD = DateFormat('yyyy/MM/dd');
final NumberFormat numMilhar = NumberFormat(",##0", "pt_BR");
