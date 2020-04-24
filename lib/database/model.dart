import 'package:flutter/material.dart';

class Senddata {
  Senddata(
      {@required this.id,
      @required this.blockid,
      @required this.Customername,
      @required this.Customernumber,
      @required this.date,
      @required this.doorno,
      @required this.time,
      @required this.type,
      @required this.reason});
  final String id;
  final String Customername;
  final String Customernumber;
  final String blockid;
  final String doorno;
  final String date;
  final String reason;
  final String time;
  final String type;

  // while using factory keyboard constructor doesn't always create a new instance of class

  factory Senddata.fromMap(Map<String, dynamic> data, documentid) {
    if (data == null) {
      return null;
    }
    final String name = data['Customername'];
    final String customerno = data['Customer number'];
    final String block = data['Block ID'];
    final String door = data['Door No'];
    final String date = data['Date'];
    final String time = data['Time'];
    final String reason = data['Reason'];
    final String type = data['Type'];

    return Senddata(
        blockid: block,
        id: documentid,
        Customername: name,
        Customernumber: customerno,
        date: date,
        doorno: door,
        time: time,
        type: type,
        reason: reason);
  }

  Map<String, dynamic> toMap() {
    return {
      'Customername': Customername,
      'Customer number': Customernumber,
      'Block ID': blockid,
      'Door No': doorno,
      'Date': date,
      'Time': time,
      'Reason': reason,
    };
  }
}

class CabData {
  CabData(
      {@required this.id,
      @required this.blockid,
      @required this.drivername,
      @required this.vehiclenumber,
      @required this.doorno,
      @required this.arrival,
      @required this.date,
      @required this.time,
      @required this.company})
      : assert(blockid != null &&
            doorno != null &&
            arrival != null &&
            date != null &&
            time != null &&
            vehiclenumber != null &&
            company != null);
  final String id;
  final String drivername;
  final String vehiclenumber;
  final String blockid;
  final String doorno;
  final String company;
  final String arrival;
  final String date;
  final String time;

  Map<String, dynamic> tosecurity() {
    return {
      'Driver Name': drivername,
      'Vehicle number': vehiclenumber,
      'Block ID': blockid,
      'Door No': doorno,
      'Excepted Arrival': arrival,
      'Company': company,
      'Received Date': date,
      'Received Time': time,
    };
  }
}

class Deliverydata {
  Deliverydata(
      {@required this.id,
      @required this.blockid,
      @required this.doorno,
      @required this.arrival,
      @required this.date,
      @required this.time,
      @required this.company})
      : assert(blockid != null &&
            doorno != null &&
            arrival != null &&
            date != null &&
            time != null &&
            company != null);
  final String id;
  final String date;
  final String time;
  final String blockid;
  final String doorno;
  final String company;
  final String arrival;

  Map<String, dynamic> deliver() {
    return {
      'Block ID': blockid,
      'Door No': doorno,
      'Excepted Arrival': arrival,
      'Company': company,
      'Received Date': date,
      'Received Time': time,
    };
  }
}

class Visitordata {
  Visitordata(
      {@required this.id,
      @required this.blockid,
      @required this.doorno,
      @required this.arrival,
      @required this.date,
      @required this.time,
      @required this.uniquecode,
      @required this.visitornumber,
      @required this.visitorname})
      : assert(blockid != null &&
            doorno != null &&
            arrival != null &&
            date != null &&
            time != null &&
            uniquecode != null &&
            visitorname != null &&
            visitorname != null);
  final String id;
  final String date;
  final String time;
  final String uniquecode;
  final String visitorname;
  final String visitornumber;
  final String blockid;
  final String doorno;
  final String arrival;

  Map<String, dynamic> visitor() {
    return {
      'Block ID': blockid,
      'Door No': doorno,
      'Unique code': uniquecode,
      'Visitor': visitorname,
      'Visitor Number': visitornumber,
      'Excepted Arrival': arrival,
      'Received Date': date,
      'Received Time': time,
    };
  }
}
