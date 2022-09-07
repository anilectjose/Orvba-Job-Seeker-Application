import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'complaint_list.dart';
import 'orvba.dart';

class Complaint_post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feedback post',
      home: MyHomePage(title: 'Feedback post'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var nameCon = new TextEditingController();
  var subjCon = new TextEditingController();
  var compCon = new TextEditingController();

  String name, subj, comp;

  SaveData(String name, String subj, String comp) async {
    var url = Orvba.BaseURL + "complaint.php";
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var Roleid = sharedPreferences.getString('roleId');
    var data = {"names": name, "subject": subj, "complaint": comp,"roleid": Roleid};
    var res = await http.post(url, body: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Orvba.themecolor,
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/backgrounds/mc7.jpg"),
                  fit: BoxFit.fill)),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: _buildForm(),
              ),
              FlatButton(
                onPressed: () {
                  print('Feedback given');
                  setState(() {
                    name = nameCon.text;
                    subj = subjCon.text;
                    comp = compCon.text;
                  });
                  SaveData(name, subj, comp);
                  Fluttertoast.showToast(
                      msg: "Feedback placed..", textColor: Colors.black);
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                color: Orvba.themecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20),
                ),
                textColor: Colors.white,
              ),
              SizedBox(height: 10),
              TextButton(
                  child: Text('View your feedback'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Complaint_view();
                    }));
                  })
            ],
          ),
        ),
      ]),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: nameCon,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Username cannot be empty';
                } else if (value.length < 3) {
                  return 'Username must be at least 3 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your Username',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: subjCon,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Subject cannot be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Subject',
                hintText: 'Give a Subject',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: compCon,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Feedback cannot be empty';
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Feedback',
                hintText: 'Feedback',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              maxLines: 10,
              maxLength: 500,
            ),
          ),
        ],
      ),
    );
  }
}
