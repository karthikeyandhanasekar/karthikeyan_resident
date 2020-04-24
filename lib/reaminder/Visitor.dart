import 'package:doorstep_resident/database/database.dart';
import 'package:doorstep_resident/database/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:secure_random/secure_random.dart';
import 'package:share/share.dart';

class Visitor extends StatefulWidget {
  @override
  _RemainderFormState createState() => _RemainderFormState();
}

TextEditingController blockcontroller = new TextEditingController();
TextEditingController doorcontroller = new TextEditingController();
TextEditingController visitornamecontroller = new TextEditingController();
TextEditingController visitornumbercontroller = new TextEditingController();
TextEditingController purposecontroller = new TextEditingController();
TextEditingController phoneNumcontroller = new TextEditingController();
TextEditingController arrivalcontroller = new TextEditingController();
final _formkey = GlobalKey<FormState>();
String documentid;
DateTime _dateTime = DateTime.now();

class _RemainderFormState extends State<Visitor> {
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
        final database = Provider.of<Database>(context, listen: false);
        var secureRandom = SecureRandom();
        String uniquecode = secureRandom.nextString(length: 5);
        print('form saved ');
        final view = Visitordata(
            //ths is the process where the data is stored
            blockid: blockcontroller.text.trim().toUpperCase(),
            visitorname: visitornamecontroller.text.trim(),
            visitornumber: visitornamecontroller.text.trim(),
            doorno: doorcontroller.text.trim(),
            id: documentid,
            arrival: _dateTime.toString(),
            date: DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
            uniquecode: uniquecode,
            time: DateFormat.jm().format(DateTime.now()).toString());
        await database.Visitor(view);
        Navigator.of(context).pop();
        final String shareuniquecode =
            "CODE : " + uniquecode + "\n Show this code to Security Guards";
        final RenderBox box = context.findRenderObject();
        Share.share(shareuniquecode,
            subject: 'DoorStep Security Services',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

        blockcontroller.clear();
        doorcontroller.clear();
        visitornamecontroller.clear();
        visitornumbercontroller.clear();
        purposecontroller.clear();
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
            icon: Icon(
              Icons.domain,
              color: Colors.grey[500],
            ),
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
            icon: Icon(
              Icons.domain,
              color: Colors.grey[500],
            ),
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
        controller: visitornamecontroller,
        decoration: InputDecoration(
          labelText: 'Visitor Name',
          icon: Icon(
            Icons.people,
            color: Colors.grey[500],
          ),
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
        controller: visitornumbercontroller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Visitor number',
          icon: Icon(
            Icons.add_call,
            color: Colors.grey[500],
          ),
          labelStyle: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text("Excepted Arrival :",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 15.0,
            textBaseline: TextBaseline.alphabetic,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
          )),
      SizedBox(
        height: 20.0,
      ),
      datetime(),
      SizedBox(
        height: 20.0,
      ),
      OutlineButton.icon(
        icon: Icon(
          Icons.save,
          color: Colors.grey[500],
        ),
        onPressed: () =>
            _submit(), // a button which  store and share the data through whatsapp
        label: Text(
          'Save',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 15.0,
          ),
        ),
      ),
    ];
  }

  Widget datetime() {
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 12, color: Colors.black),
      highlightedTextStyle: TextStyle(fontSize: 20, color: Colors.black),
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
            "Visitor",
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Color.fromRGBO(64, 75, 96, .9),
                    child: form()))));
  }
}
