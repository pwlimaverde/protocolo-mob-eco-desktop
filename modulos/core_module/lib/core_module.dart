library core_module;

import 'package:dependencies_module/dependencies_module.dart';
import 'package:objectbox/objectbox.dart';

export 'src/interfaces/module.dart';
export 'src/utils/routes.dart';
export 'src/utils/variaveis_globais.dart';
export 'src/bindings/core_module_bindings.dart';
export 'src/services/core_module_services.dart';
export 'src/core_module_controller.dart';
export 'src/entities/boleto_model.dart';
export 'src/entities/remessa_model.dart';
export 'src/entities/messages_model.dart';
export 'src/entities/imagem_modelo_model.dart';

@Entity()
class Note {
  // Each "Entity" needs a unique integer ID property.
  // Add `@Id()` annotation if its name isn't "id" (case insensitive).
  int id = 0;

  String? text;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime date;

  @Transient() // Make this field ignored, not stored in the database.
  int? notPersisted;

  // An empty default constructor is needed but you can use optional args.
  Note({this.text, DateTime? date}) : date = date ?? DateTime.now();

  // Note: just for logs in the examples below(), not needed by ObjectBox.
  toString() => 'Note{id: $id, text: $text}';
}
