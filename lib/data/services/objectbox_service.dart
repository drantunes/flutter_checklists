import 'package:flutter_checklist/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectboxService {
  late final Store store;

  ObjectboxService._create(this.store) {
    //Eventuais setups ou build queries
  }

  static Future<ObjectboxService> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "checklist_box_db"));
    return ObjectboxService._create(store);
  }
}
