class SearchModel {
  final String storeName;
  final String storeLogoUrl;
  final String storeCoverUrl;
  final String categoryName;
  final String id;

  SearchModel(
      {this.storeName,
      this.storeLogoUrl,
      this.categoryName,
      this.storeCoverUrl,
      this.id});

  SearchModel.fromJson(Map<String, dynamic> json)
      : storeName = json['store_name'].toString(),
        storeLogoUrl = json['store_logo'].toString(),
        categoryName = json['category_name'].toString(),
        storeCoverUrl = json['store_cover_image'].toString(),
        id = json['store_id'].toString();
}
