import 'package:doorstep_resident/Phone%20Authentication/login.dart';
import 'package:doorstep_resident/database/model.dart';
import 'package:doorstep_resident/database/path.dart';

import 'package:flutter/foundation.dart';
import 'firestoreservice.dart';

abstract class Database {
  Future<void> createviewer(Senddata viewer);
  Stream<List<Senddata>> readview();
}

String uniqueid() => DateTime.now().toIso8601String();

final _service = FirestoreService.instance;

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.phoneno, this.blockid})
      : assert(phoneno != null);
  final String phoneno;
  final String blockid;

  Future<void> createviewer(Senddata viewer) async {
    return _service.setdata(
      path: APIPath.senddata(
          phoneNumController.text.trim(), uniqueid()), //APIPATH1
      data: viewer.toMap(),
    );
  }

  Stream<List<Senddata>> readview() => _service.collectionStream(
        path: APIPath.readdata(phoneNumController.text.trim()),
        builder: (f, documentid) => Senddata.fromMap(f, documentid),
      );
}
