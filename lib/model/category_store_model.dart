class CategoryStoreModel {
  final String storeName;
  final String storeLogoUrl;
  final String storeCoverUrl;
  final String storeAddress;
  final String storeOwner;
  final String latitude;
  final String longitude;
  final String categoryId;
  final String id;

  CategoryStoreModel(
      {this.storeName,
      this.storeLogoUrl,
      this.storeCoverUrl,
      this.storeAddress,
      this.storeOwner,
      this.latitude,
      this.longitude,
      this.categoryId,
      this.id});

  CategoryStoreModel.fromJson(Map<String, dynamic> json)
      : storeName = json['store_name'].toString(),
        storeLogoUrl = json['store_logo'].toString(),
        storeCoverUrl = json['store_cover_image'].toString(),
        storeAddress = json['store_address'].toString(),
        latitude = json['latitude'].toString(),
        longitude = json['longitude'].toString(),
        categoryId = json['categories_id'].toString(),
        storeOwner = json['store_owner'].toString(),
        id = json['id'].toString();
}
