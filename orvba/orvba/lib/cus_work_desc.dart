import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:orvba/orvba.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cus_worker_details.dart';
class Cus_work_desc extends StatefulWidget {
  String id;

  Cus_work_desc({Key key, @required this.id}) : super(key: key);

  @override
  _Cus_work_descState createState() => _Cus_work_descState(id: id);
}

class _Cus_work_descState extends State<Cus_work_desc> {
  var compCon = new TextEditingController();
  String id, RoleId;

  _Cus_work_descState({this.id});

  SaveData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var RoleId = sharedPreferences.getString('roleId');
    print(RoleId);
    var url = Orvba.BaseURL + "make_order.php";
    var credit = {"roleid": RoleId,"workid": id};
    var res = await http.post(url, body: credit);
  }

  Future getData() async {
    var url = Orvba.BaseURL + 'cus_work_described.php';
    var credit = {"workid": id};
    var response = await http.post(url, body: credit);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Work details'),
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
        FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  List list = snapshot.data;
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Company:',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(list[index]['company'],
                              style: TextStyle(
                                  fontFamily: 'Poppins', letterSpacing: 1)),
                        ),
                        ListTile(
                          title: Text('Place:',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(list[index]['place'],
                              style: TextStyle(
                                  fontFamily: 'Poppins', letterSpacing: 1)),
                        ),
                        ListTile(
                          title: Text('Contact:',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(list[index]['number'],
                              style: TextStyle(
                                  fontFamily: 'Poppins', letterSpacing: 1)),
                        ),
                        ListTile(
                          title: Text('Worker:',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(list[index]['worker_name'],
                              style: TextStyle(
                                  fontFamily: 'Poppins', letterSpacing: 1)),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                            child: Text('View worker detail'),
                            onPressed: () {
                                String id=list[index]['worker_id'];
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Worker_Detail(id:id);
                              }));
                            })
                      ],
                    ),
                  );
                })
                : Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SaveData();
          Fluttertoast.showToast(
              msg: "Order placed..", textColor: Colors.black);
        },
        backgroundColor: Orvba.themecolor,
        child: Icon(Icons.done),
      ),
    );
  }
}
