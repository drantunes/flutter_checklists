import 'dart:io';

import 'package:flutter_checklist/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectboxService {
  late final Store store;

  ObjectboxService._create(this.store) {
    //Eventuais setups ou build queries
  }

  static Future<ObjectboxService> create() async {
    late final Directory dir;

    if (Platform.isMacOS) {
      // On macOS, use temporary directory for development to avoid sandbox issues
      // In production, you might want to use Application Support with proper entitlements
      dir = await getTemporaryDirectory();
    } else {
      // On other platforms, use Documents directory
      dir = await getApplicationDocumentsDirectory();
    }

    final store = await openStore(directory: p.join(dir.path, "checklist_box_db"));
    return ObjectboxService._create(store);
  }
}
