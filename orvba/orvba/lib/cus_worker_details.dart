import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orvba.dart';
class Worker_Detail extends StatefulWidget {
  String id;

  Worker_Detail({Key key, @required this.id}) : super(key: key);

  @override
  _Worker_DetailState createState() => _Worker_DetailState(id: id);
}

class _Worker_DetailState extends State<Worker_Detail> {
  var compCon = new TextEditingController();
  String id;

  _Worker_DetailState({this.id});

  Future getData(String id) async {
    var url = Orvba.BaseURL + 'cus_worker_detail.php';
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var Role = sharedPreferences.getString('role');
    print(Role);
    print("Worker id"+id);
    var credit = {"workid": id,"rolE": Role};
    var response = await http.post(url, body: credit);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
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
            future: getData(id),
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
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 3,
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
                                list[index]['worker_name'],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )),
                          subtitle: Center(
                              child: Text(list[index]['role'],
                                  style: TextStyle(fontFamily: 'Poppins'))),
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
                          subtitle: Text(list[index]['w_mobile'],
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
  }}