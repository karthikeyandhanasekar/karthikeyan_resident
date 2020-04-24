import 'package:doorstep_resident/Phone%20Authentication/login.dart';
import 'package:doorstep_resident/database/model.dart';
import 'package:doorstep_resident/database/path.dart';
import 'package:flutter/foundation.dart';
import 'firestoreservice.dart';

abstract class Database {
  Future<void> createviewer(Senddata viewer);
  Stream<List<Senddata>> readview();
  Future<void> Cab(CabData viewer);
  Future<void> Delivery(Deliverydata viewer);
  Future<void> Visitor(Visitordata viewer);
  Stream<List<Senddata>> sampleview() ;
}

String uniqueid() => DateTime.now().toIso8601String();

final _service = FirestoreService.firestoreservice;

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

  Future<void> Cab(CabData viewer) async {
    return _service.setdata(
      path: APIPath.cab(uniqueid()), //APIPATH1
      data: viewer.tosecurity(),
    );
  }

  Future<void> Delivery(Deliverydata viewer) async {
    return _service.setdata(
      path: APIPath.delivery(uniqueid()), //APIPATH1
      data: viewer.deliver(),
    );
  }

  Future<void> Visitor(Visitordata viewer) async {
    return _service.setdata(
      path: APIPath.visitor(uniqueid()), //APIPATH1
      data: viewer.visitor(),
    );
  }

  Stream<List<Senddata>> readview() => _service.collectionStream(
        path: APIPath.readdata(phoneNumController.text.trim()),
        builder: (f, documentid) => Senddata.fromMap(f, documentid),
      );
      Stream<List<Senddata>> sampleview() => _service.collectionStream(
        path: APIPath.sampledata(),
        builder: (f, documentid) => Senddata.fromMap(f, documentid),
      );
}
