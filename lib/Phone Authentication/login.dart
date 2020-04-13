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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: new TextFormField(
        controller: phoneNumController,
        maxLines: 1,
        keyboardType: TextInputType.numberWithOptions(decimal: false,),
        autofocus: false,
        enabled: _isloading == false,
        maxLength: 10,
        decoration: new InputDecoration(
            hintText: 'Phone NO',
            icon: new Icon(
              Icons.phone,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        //onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showSMSInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        controller: null,
        maxLines: 1,
        obscureText: false,
        autofocus: false,
        enabled: _isloading == false,
        keyboardType: TextInputType.numberWithOptions(decimal: false,),
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
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Resident'),
          elevation: 20.0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(47.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: Theme.of(context).cardColor,
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
                codesend ? showSMSInput() : Container(),
                SizedBox(
                  height: 10.0,
                ),
                loginbutton(),
              ],
            )));
  }

  Widget loginbutton() {
    return FlatButton(
      onPressed: () => codesend
          ? AuthService().signinWithOTP(smscode, verificationid)
          : verifyphoneno(phoneNumController.text.toString(), context),
      child: codesend
          ? Text(
              "Login",
              style: TextStyle(color: Colors.indigo, fontSize: 16),
            )
          : Text(
              "Verify",
              style: TextStyle(color: Colors.indigo, fontSize: 16),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumController.clear();
  }
}
