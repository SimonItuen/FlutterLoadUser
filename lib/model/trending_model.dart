class TrendingModel {
  final String id;
  final String storeName;
  final String storeLogoUrl;
  final String storeCoverUrl;
  final String categoryName;


  TrendingModel({
      this.storeName, this.storeLogoUrl, this.storeCoverUrl, this.id, this.categoryName});

  TrendingModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        storeName = json['store_name'].toString(),
        categoryName = json['category_name'].toString(),
        storeLogoUrl = json['store_logo'].toString(),
        storeCoverUrl = json['store_cover_image'].toString();

}
