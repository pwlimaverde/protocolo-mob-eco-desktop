import 'package:dependencies_module/dependencies_module.dart';

final CoreModuleController coreModuleController = Get.find();
final Store dataBase = Get.find();
final Firestore dataBaseFireBase = Get.find();
final Box<RemessaModel> dataBaseRemessa = Get.find();
final Box<BoletoModel> dataBaseBoleto = Get.find();
final Box<ImagemModeloModel> dataBaseImagem = Get.find();
final DesignSystemController designSystemController = Get.find();
// final UploadRemessaController uploadRemessaController = Get.find();
// final RemessasController remessasController = Get.find();

const double menuWidth = 200;
const double hederHeight = 60;
const double tabHeight = 40;
const String versaoAtual = "0.0.2 - By @pwlimaverde";
const String projectId = "protocolo-mob-eco-release";
const String imagemModeloProtocolo =
    "gs://protocolo-mob-ser.appspot.com/modelo/BASE-PROTOCOLO-MOB.jpeg";
final DateFormat dataFormatoDDMMYYYY = DateFormat('dd/MM/yyyy');
final DateFormat dataFormatoYYYYMMDD = DateFormat('yyyy/MM/dd');
final NumberFormat numMilhar = NumberFormat(",##0", "pt_BR");
