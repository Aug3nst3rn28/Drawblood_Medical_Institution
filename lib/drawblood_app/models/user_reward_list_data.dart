import 'package:cloud_firestore/cloud_firestore.dart';

class UserRewardList {
  final String? uid;
  final String? redeem_id;
  final String? reward_name;
  final String? status;
  final String? description;
  final Timestamp timestamp;

  UserRewardList({
    this.uid,
    this.redeem_id,
    this.reward_name,
    this.status,
    this.description,
    required this.timestamp,
  });

  static UserRewardList fromJson(Map<String, dynamic> snapshot) =>
      UserRewardList(
        uid: snapshot['uid'],
        redeem_id: snapshot['redeem_id'],
        reward_name: snapshot['reward_name'],
        status: snapshot['status'],
        description: snapshot['description'],
        timestamp: snapshot['timestamp'],
      );

  factory UserRewardList.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserRewardList(
      uid: snapshot['uid'],
      redeem_id: snapshot['redeem_id'],
      reward_name: snapshot['reward_name'],
      status: snapshot['status'],
      description: snapshot['description'],
      timestamp: snapshot['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "redeem_id": redeem_id,
        "reward_name": reward_name,
        "status": status,
        "description": description,
        "timestamp": timestamp,
      };
}
