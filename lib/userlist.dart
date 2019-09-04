import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: StreamBuilder(
          stream: Firestore.instance.collection('leaderboard').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return User(
                    name: snapshot.data.documents[index].data['name'],
                    pic: snapshot.data.documents[index].data['profile_pic'],
                    level: snapshot.data.documents[index].data['level_number'],
                    rank: snapshot.data.documents[index].data['rank'],
                    points: snapshot.data.documents[index].data['points'],
                    level_descrip:
                        snapshot.data.documents[index].data['level_descrip'],
                    badge: snapshot.data.documents[index].data['badge'],
                    created: snapshot.data.documents[index].data['created'],
                    updated: snapshot.data.documents[index].data['updated'],
                  );
                });
          }),
    );
  }
}

class User extends StatelessWidget {
  final String pic;
  final String name;
  final int level;
  final int rank;
  final int points;
  final String level_descrip;
  final String created;
  final String updated;
  final String badge;

  User(
      {this.pic,
      this.name,
      this.level,
      this.rank,
      this.points,
      this.level_descrip,
      this.created,
      this.updated,
      this.badge});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
//        decoration: BoxDecoration(gradient: _getGradient(rank)),
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                _historyDialog(context);
              },
              leading: CircleAvatar(
                minRadius: 20.0,
                maxRadius: 30.0,
                backgroundImage: NetworkImage(pic),
                backgroundColor: Colors.transparent,
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
                  percent: 1,
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
                        padding: const EdgeInsets.only(left: 3.0),
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
                  color: Colors.blueAccent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 2.0),
                      child: Text(
                        "LVL",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    Text(
                      "$level",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

//  double _getPercent(int rank) {
//    var percent;
//    if (rank == 1) {
//      percent = 1.0;
//      return percent;
//    }
//    return (1.0 - rank / 10);
//  }

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

  Future<bool> _historyDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("History"),
            content: Container(
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('leaderboard_history')
                    .snapshots(),
                builder: (context, snapshots) {
                  //NOTE : We use 'uid'(From Auth)instead of index while fetching a specific document for that particular user.
                  String email = snapshots.data.documents[0].data['email'];
                  String created = snapshots.data.documents[0].data['created'];
                  String updated = snapshots.data.documents[0].data['updated'];
                  int total_pts =
                      snapshots.data.documents[0].data['total_points'];
                  String reason =
                      snapshots.data.documents[0].data['reason_points'];

                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Email : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(email),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Reason : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Expanded(
                                child: Text(
                              reason,
                              maxLines: 3,
                            )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Total Points : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(total_pts.toString()),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Created On : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(created),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Updated On  : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(updated),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
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
