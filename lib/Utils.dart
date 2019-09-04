import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  getLeaderboardData() async {
    return await Firestore.instance.collection('leaderboard').snapshots();
  }

  getLeaderboardHistory() async {
    return await Firestore.instance
        .collection('leaderboard_history')
        .snapshots();
  }
}
