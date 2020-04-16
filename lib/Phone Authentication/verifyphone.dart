import 'package:doorstep_resident/Phone%20Authentication/authservice.dart';
import 'package:doorstep_resident/Phone%20Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> verifyphoneno(                                        //This page is fully about phone verification process
    phoneno,
    BuildContext
        context) async // function that handle all the process of phone auth
{
  try {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) //  process completed var
        {
      AuthService().singin(credential);
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      // process failed var
      print('Verification failed : ${exception.message}');
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Verification failed"),
              content: Text("${exception.message} "),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("ok"))
              ],
            );
          });
    };

    final PhoneCodeSent codesent =                                          
        (String verID, [int Forceresent]) //otp send to user var
        {
      verificationid = verID;
    };
    final PhoneCodeAutoRetrievalTimeout autoreterive = (String verID) //Don't no
        {
      verificationid = verID;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(                             //firebase verifiying phone build-in function 
        phoneNumber: "+91" + phoneNumController.text.toString(),
        timeout: const Duration(seconds: 4),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codesent,
        codeAutoRetrievalTimeout: autoreterive);
  } catch (e) {
    print("PRocess Error : ${e.toString()}");
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Authentication failed"),
            content: Text("${e.message} "),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("ok"))
            ],
          );
        });
  };
  
}
