import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orvba/view_cuscomp_desc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'complaint_desc.dart';
import 'orvba.dart';

class Cus_complaint_view extends StatefulWidget {
  @override
  _Cus_complaint_viewState createState() => _Cus_complaint_viewState();
}

class _Cus_complaint_viewState extends State<Cus_complaint_view> {
  Future getData() async {
    var url = Orvba.BaseURL+'customer_complaint_view.php';
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var Roleid = sharedPreferences.getString('roleId');
    var credit = {"roleid": Roleid};
    var response = await http.post(url, body: credit);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                    return ListView.builder(
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
                                      Text(list[index]['complaint_id'],
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
                                              list[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Text(
                                            list[index]['subject'],
                                            style: TextStyle(),
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
                                        print('Feedback described');
                                        String id=list[index]['complaint_id'];
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return Cus_complaint_desc(id:id);
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
