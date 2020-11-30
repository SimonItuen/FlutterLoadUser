class LoadRewardItemsModel {
  final String rewardId;
  final String rewardImage;



  LoadRewardItemsModel( {this.rewardId, this.rewardImage});

  LoadRewardItemsModel.fromJson(Map<String, dynamic> json)
      : rewardId = json['reward_id'].toString(),
        rewardImage= json['reward_image'].toString();

}

