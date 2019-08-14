import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          //Fetch List for leaderboard of type User

          //Dummy Data
          User(
            pic: "assets/profile.png",
            name: "SouL Mortal",
            level: 141,
            points: 1034,
            rank: 1,
          ),
          User(
            pic: "assets/profile.png",
            name: "SouL Mortal",
            level: 134,
            points: 981,
            rank: 2,
          ),
          User(
            pic: "assets/profile.png",
            name: "SouL Mortal",
            level: 129,
            points: 944,
            rank: 3,
          ),
          User(
            pic: "assets/profile.png",
            name: "SouL Mortal",
            level: 127,
            points: 942,
            rank: 4,
          ),
          User(
            pic: "assets/profile.png",
            name: "SouL Mortal",
            level: 112,
            points: 860,
            rank: 5,
          ),
        ],
      ),
    );
  }
}

class User extends StatelessWidget {
  final String pic;
  final String name;
  final int level;
  final int points;
  final int rank;

  User({this.pic, this.name, this.level, this.points, this.rank});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
//        decoration: BoxDecoration(gradient: _getGradient(rank)),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                minRadius: 20.0,
                maxRadius: 30.0,
                backgroundImage: AssetImage(pic),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "$rank.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: "Lato"),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          fontFamily: "ProductSans"),
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(5.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 180,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: _getPercent(rank),
                  center: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                            boxShadow: [
                              BoxShadow(color: Colors.yellow, blurRadius: 5.0)
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:3.0),
                        child: Text(
                          "$points",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      const Color(0xfffa52a6),
                      const Color(0xff1469c9),
                    ],
                  ),
                ),
              ),
              trailing: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfffa52a6),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0,4.0,2.0,2.0),
                      child: Text(
                        "LVL",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,

                            ),
                      ),
                    ),
                    Text("$level",style: TextStyle(

                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,

                    ),),
                  ],
                ),
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }

  double _getPercent(int rank) {
    var percent;
    if (rank == 1) {
      percent = 1.0;
      return percent;
    }
    return (1.0 - rank / 10);
  }

  LinearGradient _getGradient(int rank) {
    switch (rank) {
      case 1:
        {
          return LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              const Color(0xffB48811),
              const Color(0xffEBD197),
            ],
          );
          break;
        }
      case 2:
        {
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              const Color(0xffA1A2A3),
              const Color(0xffBEC0C2),
            ],
          );
          break;
        }
      case 3:
        {
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              const Color(0xff804A00),
              const Color(0xffB08D57),
            ],
          );
          break;
        }
      default:
        {
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              const Color(0xfffa52a6),
              const Color(0xff1469c9),
            ],
          );
          break;
        }
    }
  }
}

/*
Row(
                    children: <Widget>[
                      Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.yellowAccent, blurRadius: 10.0)
                            ]),
                      ),
                      Text("$points"),
                    ],
                  )
 */
