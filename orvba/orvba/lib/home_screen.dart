import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orvba/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'complaint.dart';
import 'cus_work_type.dart';
import 'orvba.dart';
import 'login_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _SampleState createState() => new _SampleState();
}

class _SampleState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
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
              padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: <Widget>[
                  FlatButton(
                    onPressed:(){
                      print('Profile Button Pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Profile();
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
                      print('Assist Button Pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Cus_work_type();
                      }));
                    },
                    child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/icons/assist.png",
                                height: 100.0,
                                width: 100.0,),
                            ),
                            Center(
                              child: Text("Road assist"),
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
                      print('View details Button Pressed');
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
                              child: Text("View recent"),
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
