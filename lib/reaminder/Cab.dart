import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/database/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class Cab extends StatefulWidget {
  @override
  _RemainderFormState createState() => _RemainderFormState();
}

TextEditingController blockcontroller = new TextEditingController();
TextEditingController doorcontroller = new TextEditingController();
TextEditingController drivercontroller = new TextEditingController();
TextEditingController vehiclenumcontroller = new TextEditingController();
TextEditingController companycontroller = new TextEditingController();
TextEditingController phoneNumcontroller = new TextEditingController();
TextEditingController arrivalcontroller = new TextEditingController();
final _formkey = GlobalKey<FormState>();
String documentid;
DateTime _dateTime = DateTime.now();

class _RemainderFormState extends State<Cab> {
  bool _validateandSaveForm() {
    //   it validate the form given below
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save(); // it save the form with current value
      return true;
    }
    return false;
  }

  Widget form() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(45.0),
      child: Form(
        key: _formkey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildformchildren()),
      ),
    );
  }

  void _submit() async {
    if (_validateandSaveForm()) {
      try {
        //check the  bool function
        final database = Provider.of<Database>(context,
            listen:
                false); //get database abstract class from database folder and initalize to final database using provider package

        print('form saved ');
        final view = CabData(
            //ths is the process where the data is stored
            blockid: blockcontroller.text.trim().toUpperCase(),
            drivername: drivercontroller.text.trim(),
            vehiclenumber: vehiclenumcontroller.text.trim().toUpperCase(),
            doorno: doorcontroller.text.trim(),
            company: companycontroller.text.trim(),
            id: documentid,
            arrival: _dateTime.toString(),
            date: DateFormat.yMMMMEEEEd().format(DateTime.now()),
            time: DateFormat.jm().format(DateTime.now()));

        await database.Cab(view);
        Navigator.of(context).pop();
        blockcontroller.clear();
        doorcontroller.clear();
        vehiclenumcontroller.clear();
        drivercontroller.clear();
        companycontroller.clear();
        phoneNumcontroller.clear();
      } catch (e) {
        print(e.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Uploading data failed"),
                content: Text("${e.message}"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Ok"))
                ],
              );
            });
      }
    }
  }

  List<Widget> _buildformchildren() {
    //input field and button inside the card
    return [
      TextFormField(
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.grey[100],
        ),
        controller: blockcontroller,
        decoration: InputDecoration(
            labelText: 'Block ID',
            icon: Icon(Icons.domain,),
            labelStyle: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            )),
      ),
      TextFormField(
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.grey[100],
        ),
        controller: doorcontroller,
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        decoration: InputDecoration(
            labelText: 'Door Number',
            icon: Icon(Icons.domain,color: Colors.grey[500]),
            labelStyle: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            )),
      ),
      TextFormField(
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.grey[100],
        ),
        controller: drivercontroller,
        decoration: InputDecoration(
          labelText: 'Driver Name',
          icon: Icon(Icons.people,color: Colors.grey[500],),
          labelStyle: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      TextFormField(
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.grey[100],
        ),
        controller: vehiclenumcontroller,
        decoration: InputDecoration(
          labelText: 'Vehicle number',
          icon: Icon(Icons.add_call,color: Colors.grey[500]),
          labelStyle: TextStyle(
           color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      TextFormField(
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.grey[100],
        ),
        controller: companycontroller,
        decoration: InputDecoration(
          labelText: 'Company Name',
          icon: Icon(Icons.question_answer,color: Colors.grey[500],),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[500]
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Text("Excepted Arrival :",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 15.0,
            textBaseline: TextBaseline.alphabetic,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
          )),
      SizedBox(
        height: 10.0,
      ),
      datetime(),
      SizedBox(
        height: 10.0,
      ),
      OutlineButton.icon(
        icon: Icon(
          Icons.save,
          color: Colors.grey[100],
        ),
        onPressed: () =>
            _submit(), // a button which  store and share the data through whatsapp
        label: Text(
          'Save',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 15.0,
          ),
        ),
      ),
    ];
  }

  Widget datetime() {
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 12, color: Colors.white),
      highlightedTextStyle: TextStyle(fontSize: 20, color: Colors.white),
      spacing: 20,
      itemHeight: 20,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
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
            "Cab",
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Card(
                    color: Color.fromRGBO(64, 75, 96, .9),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: form()))));
  }
}
