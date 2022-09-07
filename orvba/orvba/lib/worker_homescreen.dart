import 'package:flutter/material.dart';
import 'package:orvba/profile.dart';
import 'package:orvba/view_cus_complaints.dart';
import 'package:orvba/worker_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'complaint.dart';
import 'login_page.dart';
import 'orvba.dart';

class WorkerHomesreen extends StatefulWidget {
  @override
  _WorkerHomesreenState createState() => _WorkerHomesreenState();
}

class _WorkerHomesreenState extends State<WorkerHomesreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Worker Dashboard"),
          backgroundColor: Orvba.themecolor,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: null)],
        ),
        body:Stack(
          children: [
            Container(
              decoration: BoxDecoration(image: DecorationImage(
                  image: AssetImage("assets/backgrounds/mc7.jpg"),
                  fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: <Widget>[
                  FlatButton(
                    onPressed:(){
                      print('Profile Button Pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                          return WProfile();
                      }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/icons/profile.png",
                                height: 100.0,
                                width: 100.0,),
                            ),
                            Center(
                              child: Text("Profile"),
                            )
                          ],
                        )
                    ),
                  ),
                  FlatButton(
                    onPressed:(){
                      print('View works Button Pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        // return Covid_cases();
                      }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/icons/recent.png",
                                height: 100.0,
                                width: 100.0,),
                            ),
                            Center(
                              child: Text("View works"),
                            )
                          ],
                        )
                    ),
                  ),
                  FlatButton(
                    onPressed:(){
                      print('Add details Button Pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        // return Covid_cases();
                      }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/icons/covid.png",
                                height: 100.0,
                                width: 100.0,),
                            ),
                            Center(
                              child: Text("Add post"),
                            )
                          ],
                        )
                    ),
                  ),
                  FlatButton(
                    onPressed:(){
                      print('Complaint edit Button Pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Complaint_post();
                      }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/icons/writecomplaint.png",
                                height: 100.0,
                                width: 100.0,),
                            ),
                            Center(
                              child: Text("Feedback"),
                            )
                          ],
                        )
                    ),
                  ),
                  FlatButton(
                    onPressed:(){
                      print('Complaint view Button Pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Cus_complaint_view();
                      }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/icons/complaint.png",
                                height: 100.0,
                                width: 100.0,),
                            ),
                            Center(
                              child: Text("View Feedback"),
                            )
                          ],
                        )
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      print('Log out Button Pressed');
                      final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                      sharedPreferences.remove('role');
                      sharedPreferences.remove('email');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/icons/logout.png",
                                height: 100.0,
                                width: 100.0,),
                            ),
                            Center(
                              child: Text("Logout"),
                            )
                          ],
                        )
                    ),
                  ),
                ],

              ),),



          ],
        ) ,
      ),
    );
  }
}
