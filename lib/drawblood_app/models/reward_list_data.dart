import 'package:cloud_firestore/cloud_firestore.dart';

class RewardModel {
  final String? reward_name;
  final String? description;
  final String? redeem_point;

  RewardModel({
    this.reward_name,
    this.description,
    this.redeem_point,
  });

  factory RewardModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return RewardModel(
      reward_name: snapshot['reward_name'],
      description: snapshot['description'],
      redeem_point: snapshot['redeem_point'],
    );
  }

  Map<String, dynamic> toJson() => {
        "reward_name": reward_name,
        "description": description,
        "redeem_point": redeem_point,
      };
}
