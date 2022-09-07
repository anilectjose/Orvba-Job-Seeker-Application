import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'orvba.dart';

class Edit_Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Profile',
      home: MyHomePage(title: 'Edit Profile'),
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
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var nameCon = new TextEditingController();
  var mobCon = new TextEditingController();
  var emailCon = new TextEditingController();
  var addCon = new TextEditingController();

  String name, pass, phone, mail, Roleid,address;

  SaveData(String name, String pass, String phone, String mail, String Roleid, String address) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var Roleid = sharedPreferences.getString('roleId');
    var Role = sharedPreferences.getString('role');
    print(Roleid);
    var url = Orvba.BaseURL + "edit_profile.php";

    var data = {
      "names": name,
      "password": pass,
      "phonen": phone,
      "mailid": mail,
      "RoleID": Roleid,
      "address": address,
      "role": Role
    };
    var res = await http.post(url, body: data);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: _buildForm(),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            debugPrint('All validations passed!!!');
          }
          setState(() {
            name = nameCon.text;
            pass = _passwordController.text;
            phone = mobCon.text;
            mail = emailCon.text;
            address = addCon.text;
          });
          SaveData(name, pass, phone, mail, Roleid,address);
        },
        backgroundColor: Orvba.themecolor,
        child: Icon(Icons.done),
      ),
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
              controller: emailCon,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Mail id cannot be empty';
                }
                /*else if (value.length < 3) {
                  return 'Username must be at least 3 characters long.';
                }*/
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email id',
                hintText: 'Enter Mail id',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: mobCon,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Mobile cannot be empty';
                } else if (value.length < 10 || value.length > 10) {
                  return 'Mobile num must be 10 digits';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile',
                hintText: 'Enter Mobile number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordController,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Password cannot be empty';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter New Password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  child: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              obscureText: !_showPassword,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _confirmPasswordController,
              validator: (String value) {
                if (value != _passwordController.value.text) {
                  return 'Passwords do not match!';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm new password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              controller: addCon,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Address cannot be empty';
                } else if (value.length < 10) {
                  return 'Address must be at least 3 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
