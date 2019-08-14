import 'package:flutter/material.dart';
import 'userlist.dart';

void main() => runApp(LeaderBoard());

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      const Color(0xfffa52a6),
                      const Color(0xff1469c9),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 78.0),
                  child: Text(
                    "LEADERBOARD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Mikado",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 38.0),
                  ),
                ),
              ),

              Positioned(
                top: 180.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 3.0)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(44.0)),
                  child: UserList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
