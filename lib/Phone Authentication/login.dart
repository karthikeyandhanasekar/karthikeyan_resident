import 'package:doorstep_resident/Phone%20Authentication/authservice.dart';
import 'package:doorstep_resident/Phone%20Authentication/verifyphone.dart';

import 'package:flutter/material.dart';

class PhoneSignin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

final _formKey = new GlobalKey<FormState>();

String id;
bool _isloading = false;

final phoneNumController = new TextEditingController();
String verificationid, smscode;
bool codesend = false;

class _SigninState extends State<PhoneSignin> {
  Widget showPhoneInput() {
    //phone input
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: new TextFormField(
        style: TextStyle(color: Colors.grey[100], fontSize: 18),
        controller: phoneNumController,
        maxLines: 1,
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
        ),
        autofocus: false,
        enabled: _isloading == false,
        maxLength: 10,
        decoration: new InputDecoration(
            hintText: 'Phone NO',
            hintStyle: TextStyle(color: Colors.grey[500]),
            icon: new Icon(
              Icons.phone,
              color: Colors.grey[100],
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showSMSInput() {
    //sms code input
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        controller: null,
        maxLines: 1,
        obscureText: false,
        autofocus: false,
        enabled: _isloading == false,
        keyboardType: TextInputType.numberWithOptions(
          decimal: false,
        ),
        decoration: new InputDecoration(
            hintText: 'SMS',
            icon: new Icon(
              Icons.sms,
              color: Colors.grey,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          title: Text(
            "Resident",
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(47.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color:  Color.fromRGBO(64, 75, 96, .9),
              elevation: 5.0,
              child: showForm(context),
            ),
          ),
        ));
  }

  Widget showForm(BuildContext context) {
    return new Container(
        padding: EdgeInsets.all(5.0),
        child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              shrinkWrap: true,
              children: <Widget>[
                showPhoneInput(),
                SizedBox(
                  height: 10.0,
                ),
                codesend
                    ? showSMSInput()
                    : Container(), // ternary operator used , if(codesend) showSMSInput() else Container()
                SizedBox(
                  height: 10.0,
                ),
                loginbutton(), //login button  function
              ],
            )));
  }

  Widget loginbutton() {
    return FlatButton(
      onPressed: () => codesend //ternary operator is used
          ? AuthService().signinWithOTP(smscode, verificationid)
          : verifyphoneno(phoneNumController.text.toString(), context),
      child: codesend //just name changed based on codesent
          ? Text(
              "Login",
              style: TextStyle(color: Colors.grey[100], fontSize: 16),
            )
          : Text(
              "Verify",
              style: TextStyle(color: Colors.grey[100], fontSize: 16),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumController.clear();
  }
}
