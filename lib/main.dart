import 'package:doorstep_resident/Phone%20Authentication/authservice.dart';
import 'package:doorstep_resident/Phone%20Authentication/login.dart';
import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/show.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

//adding remaindersection
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Database>(
        create: (_) =>
            FirestoreDatabase(phoneno: phoneNumController.text, blockid: null),
        child: MaterialApp(
          title: 'DoorStep Resident',
          /*theme: ThemeData(
            primaryColor: Colors.indigo[700],
            accentColor: Colors.indigo,
            backgroundColor:
                Colors.indigo[100], // change background color for all pages
            cardColor:
                Colors.indigo[100], // change card color for all the card used
          ),*/
          darkTheme: ThemeData.dark(), //dark theme
          debugShowCheckedModeBanner:
              false, // It hide the debug banner while in debug mode
          home: AuthService().handleAuth(),
         //home: Show(),
         
        ));
  }
}
