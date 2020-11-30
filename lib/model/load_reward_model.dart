import 'package:load/model/load_reward_items_model.dart';
class LoadRewardModel {
  final String id;
  final bool isLocked;
  final String rewardName;
  final String createdAt;
  final String requiredLoadPoints;
  final List<LoadRewardItemsModel> list;


  LoadRewardModel( {this.id, this.isLocked, this.rewardName,this.createdAt, this.requiredLoadPoints, this.list});

  factory LoadRewardModel.fromJson(Map<String, dynamic> json) {
    List<LoadRewardItemsModel> list = new List<LoadRewardItemsModel>();
    for (Map i in json['rewards']) {
      list.add(LoadRewardItemsModel.fromJson(i));
    }
    return LoadRewardModel(
        id: json['id'].toString(),
        isLocked: json['is_locked'].toString()!='1',
        rewardName: json['reward_name'].toString(),
        requiredLoadPoints: json['required_load_points'].toString(),
        createdAt: json['created_at'].toString(),
        list: list);
  }

}

