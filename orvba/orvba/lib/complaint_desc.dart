import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'orvba.dart';


class Complaint_desc extends StatefulWidget {
  String id;
  Complaint_desc({Key key,@required this.id}) : super(key: key);

  @override
  Complaint_descState createState() => Complaint_descState(id: id);
}

class Complaint_descState extends State<Complaint_desc> {

  String id;
  Complaint_descState({this.id});

  Future getData() async {
    var url = Orvba.BaseURL+'complaint_described.php';
    var credit = {"compid": id};
    var response = await http.post(url, body: credit);
    print(id);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Feedback'),
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
                              title: Text('Name:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(list[index]['name'],
                                  style: TextStyle(
                                      fontFamily: 'Poppins', letterSpacing: 1)),
                            ),
                            ListTile(
                              title: Text('Subject:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(list[index]['subject'],
                                  style: TextStyle(
                                      fontFamily: 'Poppins', letterSpacing: 1)),
                            ),
                            ListTile(
                              title: Text('Feedback:',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(list[index]['complaint'],
                                  style: TextStyle(
                                      fontFamily: 'Poppins', letterSpacing: 1)),
                            ),
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
    );
  }
}
