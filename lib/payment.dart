import 'package:doorstep_resident/Phone%20Authentication/login.dart';
import 'package:doorstep_resident/database/database.dart';
import 'package:upi_india/upi_india.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

GlobalKey bottomNavigationKey = GlobalKey();
Future _transaction;
String status;

/*void updatepaymentdetails(String app, BuildContext context) async {
  try {
    Map<String, dynamic> paymentdetails() {
      return {
        'Resident Number': phoneNumController.text.trim(),
        'Transcation ID': _transaction,
        'Transcation Status': status,
        'UPI Reference ID': null,
        'Amount' : 2.0,
        'Payment date':
            DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
        'Payment Time': DateFormat.jm().format(DateTime.now()).toString(),
        'UPI App': app,
      };
    }

    String uniqueid() => DateTime.now().toIso8601String();
    String setpath(String residentnumber, String uniqueid) =>
        '/payment/resident/$residentnumber/$uniqueid()';
    final path = setpath(phoneNumController.text.trim(), uniqueid());
    final reference = await Firestore.instance.document(path);
    reference.setData(paymentdetails());
    print('$path : $paymentdetails()');
  } catch (e) {
    print(e.message);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Payment Details Upload Failed"),
            content: Text("${e.message}"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Ok"))
            ],
          );
        });
  }
}*/

class _PaymentState extends State<Payment> {
  Future<String> initiateTransaction(String app) async {
    UpiIndia upi = new UpiIndia(
      app: app,
      receiverUpiId: 'dkkarthik2000@okaxis',
      receiverName: 'DoorStep',
      transactionRefId: 'TestingId',
      transactionNote: 'DoorStep Maintenance',
      amount: 2.00,
    );

    String response = await upi.startTransaction();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            "Payment",
            style: TextStyle(
              fontFamily: 'Roboto',
      ),
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: StadiumBorder(),
              elevation: 15.0,
              child: Text("GOOGLE PAY",
                  style: TextStyle(
                    color: Colors.blueGrey[500],
                    fontSize: 15.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  )),
              color: Colors.tealAccent,
              onPressed: () {
                _transaction = initiateTransaction(
                  UpiIndiaApps.GooglePay,
                );
                setState(() {
                  //updatepaymentdetails('Google Pay', context);
                });
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              elevation: 15.0,
              child: Text("PAYTM",
                  style: TextStyle(
                    color: Colors.blueGrey[500],
                    fontSize: 15.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  )),
              color: Colors.tealAccent,
              onPressed: () {
                _transaction = initiateTransaction(
                  UpiIndiaApps.PayTM,
                );
                setState(() {
                  //updatepaymentdetails('PayTm', context);
                });
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              elevation: 15.0,
              focusColor: Colors.blue,
              child: Text("AMAZON PAY",
                  style: TextStyle(
                    color: Colors.blueGrey[500],
                    fontSize: 15.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Roboto',
                  )),
              color: Colors.tealAccent,
              onPressed: () {
                _transaction = initiateTransaction(
                  UpiIndiaApps.AmazonPay,
                );
                setState(() {
                  //updatepaymentdetails('Amazon Pay', context);
                });
              },
            ),
            FutureBuilder(
                future: _transaction,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null)
                    return Text('');
                  else {
                    switch (snapshot.data.toString()) {
                      case UpiIndiaResponseError.APP_NOT_INSTALLED:
                        return Text('App not installed.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                            ));
                        break;
                      case UpiIndiaResponseError.INVALID_PARAMETERS:
                        return Text(
                          'App is unable to handle request.',
                        );
                        break;
                      case UpiIndiaResponseError.USER_CANCELLED:
                        return Text(
                            'It seems like you cancelled the transaction.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                            ));
                        break;
                      case UpiIndiaResponseError.NULL_RESPONSE:
                        return Text('No data received',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Roboto',
                            ));
                        break;
                      default:
                        UpiIndiaResponse _upiResponse;
                        _upiResponse = UpiIndiaResponse(snapshot.data);
                        /*String*/ status = _upiResponse.status;
                        return Column(
                          children: <Widget>[
                            Text(
                              'Status: $status',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                textBaseline: TextBaseline.alphabetic,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        );
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
