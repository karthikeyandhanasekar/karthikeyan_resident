import 'package:doorstep_resident/Phone%20Authentication/authservice.dart';
import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/database/model.dart';
import 'package:doorstep_resident/payment.dart';
import 'package:doorstep_resident/platoformalertdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:fab_menu/fab_menu.dart';
import 'reaminder/Cab.dart';
import 'package:doorstep_resident/reaminder/Delivery.dart';
import 'package:doorstep_resident/reaminder/Visitor.dart';

class Show extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  List<MenuData> menuDataList;

  @override
  void initState() {
    super.initState();
    menuDataList = [
      new MenuData(Icons.local_taxi, (context, menuData) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Cab()));
      }, labelText: 'Cab'),
      new MenuData(Icons.fastfood, (context, menuData) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Delivery()));
      }, labelText: 'Delivery'),
      new MenuData(Icons.people, (context, menuData) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Visitor()));
      }, labelText: 'Visitor'),
      new MenuData(Icons.payment, (context, menuData) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Payment()));
      }, labelText: 'Payment'),
    ];
  }

  Future<void> logout(BuildContext context) async {
    //logout function
    try {
      await AuthService().signout();
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Failed to Logout"),
              content: Text("${e.toString()}"),
            );
          });
    }
  }

  Future<void> confirmsignout(BuildContext context) async {
    //display dialog whether logout or not
    final didrequest = await PlatformAlertDialog(
      title: 'Log out',
      content: 'Are you sure',
      cancelactiontext: 'Cancel',
      defaultactiontext: 'Logout',
    ).show(context);
    if (didrequest == true) logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            "Visitor List",
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
          elevation: 0.1,
          actions: <Widget>[
            FlatButton(
                //button to logout
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                ),
                onPressed: () => confirmsignout(context)),
          ],
        ),
        floatingActionButton: new FabMenu(
          menus: menuDataList,
          maskOpacity: 0,
          mainIcon: Icons.menu,
          mainButtonBackgroundColor: Colors.tealAccent,
          mainButtonColor: Colors.blueGrey,
          menuButtonBackgroundColor: Colors.white,
          labelTextColor: Colors.blueAccent,
          labelBackgroundColor: Colors.white,
        ),
        floatingActionButtonLocation: fabMenuLocation,
        body:
            /* Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildcontext(context),
        ));*/
            sample(context));
  }

  Widget sample(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Senddata>>(
        stream: database.readview(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final viewer = snapshot.data;
            final children = viewer
                .map((datarev) => Card(
                      elevation: 20.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0,
                                            color: Colors.white24))),
                                child: Text(
                                  '${datarev.type}\n${datarev.reason}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.tealAccent,
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                              title: Text(
                                '${datarev.Customername}',
                                style: TextStyle(
                                    color: Colors.grey[100], fontWeight: null),
                              ),
                              //subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              subtitle: Row(
                                children: <Widget>[
                                  Icon(Icons.linear_scale,
                                      color: Colors.yellowAccent),
                                  Text('${datarev.date}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.w800))
                                ],
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.white, size: 30.0),
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                              dialogBackgroundColor:
                                                  Color.fromRGBO(
                                                      64, 75, 96, .9)),
                                          child: AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                              BorderRadius.circular(10)),
                                            title: Text(
                                              'Full Details',
                                              style: TextStyle(
                                                  color: Colors.blueGrey[50]),
                                            ),
                                            content: Text(
                                              'Block ID: ${datarev.blockid}\nDoor No: ${datarev.doorno}\nVisitor: ${datarev.Customername}\nVisitor number: ${datarev.Customernumber}\n Date: ${datarev.date}\nTime: ${datarev.time}\nType: ${datarev.type}\nReason: ${datarev.reason}',
                                              style: TextStyle(
                                                color: Colors.blueGrey[50],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text("ok"),
                                              )
                                            ],
                                          ),
                                        );
                                      })))),
                    ))
                .toList();
            return ListView(
              children: children.reversed.toList(),
            );
          }
          return Center(
              //Loading screen process
              child: Column(
            children: <Widget>[
              LoadingBouncingGrid.circle(backgroundColor: Colors.tealAccent,),
              SizedBox(height: 10,),
              Text(
                "Your session has expired, Please login again",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  textBaseline: TextBaseline.alphabetic,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ));
        });
  }

  Widget _buildcontext(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Senddata>>(
        stream: database.readview(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final viewer = snapshot.data;
            final children = viewer
                .map((datarev) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                          5.0,
                        )),
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            //here the data retrive from firestore
                            '  DoorStep Security Services \n\n Visitor: ${datarev.Customername}\n Visitor number: ${datarev.Customernumber},\n Block ID: ${datarev.blockid},\n Door No: ${datarev.doorno},\n Date: ${datarev.date}\n Time: ${datarev.time}\n Reason: ${datarev.reason}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              textBaseline: TextBaseline.alphabetic,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList();
            return ListView(children: children.reversed.toList());
          }
          return Center(
              //Loading screen process
              child: Column(
            children: <Widget>[
              LoadingBouncingGrid.circle(),
              Text(
                "Your session has expired, Please login again",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  textBaseline: TextBaseline.alphabetic,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ));
        });
  }
}
