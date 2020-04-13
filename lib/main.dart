//import 'dart:async';

import 'package:doorstep_resident/Phone%20Authentication/authservice.dart';
import 'package:doorstep_resident/Phone%20Authentication/login.dart';
import 'package:doorstep_resident/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Database>(
      create: (_) =>
          FirestoreDatabase(phoneno: phoneNumController.text, blockid: null),
      child: MaterialApp(
          title: 'DoorStep Resident',
          theme: ThemeData(
            primaryColor: Colors.indigo[700],
            accentColor: Colors.indigo,
            backgroundColor: Colors.indigo[100],
            cardColor: Colors.indigo[100],
          ),
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: AuthService().handleAuth(),)
    );
  }
}
