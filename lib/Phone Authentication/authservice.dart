import 'package:doorstep_resident/Phone%20Authentication/login.dart';
import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/show.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doorstep_resident/Phone Authentication/login.dart';

class AuthService {
  handleAuth() {
    //check whether user is login or not
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Provider<Database>(
              create: (_) => FirestoreDatabase(
                  phoneno: phoneNumController.text.trim(),
                  blockid: null),
              child: Show(),
            );
          } else {
            return PhoneSignin();
          }
        });
  }

  signout() // signout
  {
    FirebaseAuth.instance.signOut();
  }

  singin(AuthCredential credential) //signin
  {
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  signinWithOTP(smscode, verID) // otp
  {
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verID, smsCode: smscode);
    singin(credential);
  }

  void authresult() async {
    AuthResult result =
        await FirebaseAuth.instance.currentUser().then((onValue) {
      print(onValue.uid); // print the user uniqueid
    });
  }
}
