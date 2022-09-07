import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';
import 'orvba.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String Roleid, ROLE;

  @override
  Widget build(BuildContext context) {

    Future getData(String Roleid, String Role) async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var Roleid = sharedPreferences.getString('roleId');
      var ROLE = sharedPreferences.getString('role');
      print(Roleid);
      print(ROLE);
      var url = Orvba.BaseURL + "profile.php";
      var credit = {"roleid": Roleid,"rolE": ROLE};
      var response = await http.post(url, body: credit);
      return json.decode(response.body);
    }

    return WillPopScope(
      child: Scaffold(
          body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/backgrounds/mc7.jpg"),
                  fit: BoxFit.fill)),
        ),
        FutureBuilder(
          future: getData(Roleid, ROLE),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Stack(
                            overflow: Overflow.visible,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/backgrounds/profile_b.jpg"),
                              ),
                              Positioned(
                                bottom: -60.0,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('assets/icons/profile.png'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          ListTile(
                            title: Center(
                                child: Text(
                              list[index]['customer_name'],
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                            subtitle: Center(
                                child: Text(list[index]['role'],
                                    style: TextStyle(fontFamily: 'Poppins'))),
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              print('Edit Button Pressed');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Edit_Profile();
                                Navigator.pop(context);
                              }));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Poppins'),
                            ),
                            color: Orvba.themecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          ListTile(
                            title: Text('Mail id',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(list[index]['mail'],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            title: Text('Mobile',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(list[index]['mobile'],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            title: Text('Address',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(list[index]['address'],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ]),
      ),
    );
  }
}
