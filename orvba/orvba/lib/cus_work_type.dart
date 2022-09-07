import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orvba/orvba.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cus_work_list.dart';

class Cus_work_type extends StatefulWidget {
  String id;
  Cus_work_type({Key key, @required this.id}) : super(key: key);

  @override
  _Cus_work_typeState createState() => _Cus_work_typeState(id: id);
}

class _Cus_work_typeState extends State<Cus_work_type> {
  String id,Roleid;
  _Cus_work_typeState({this.id});


  Future getData() async {
    var url = Orvba.BaseURL+'type_view.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: new Text('Select specifications'),
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
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext, int index) => Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(0.0)),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(list[index]['type_id'],
                                            style: TextStyle(
                                                fontSize: 0)),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width,
                                              child: Text(
                                                list[index]['type_name'],
                                                style: TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 5),
                                      child: FlatButton(
                                        onPressed: () {
                                          String id=list[index]['type_id'];
                                          print(id);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return WorkList(id:id);
                                                  }));
                                        },
                                        color: Orvba.themecolor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "View",
                                        ),
                                        textColor: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
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
