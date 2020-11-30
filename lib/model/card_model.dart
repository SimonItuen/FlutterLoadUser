class CardModel {
  final String storeName;
  final String storeLogoUrl;
  final String storeCoverUrl;
  final String points;
  final String cardImageUrl;
  final String storeId;
  final String storeFontColor;
  final String storeCardBgColor;

  CardModel(
      {this.storeId,
      this.storeName,
      this.storeLogoUrl,
      this.storeCoverUrl,
      this.cardImageUrl,
      this.points,
      this.storeFontColor,
      this.storeCardBgColor});

  CardModel.fromJson(Map<String, dynamic> json)
      : storeId = json['store_id'].toString(),
        storeName = json['store_name'].toString(),
        storeLogoUrl = json['store_logo'].toString(),
        storeFontColor = json['store_font_color'].toString().replaceAll('#', '0xFF'),
        storeCardBgColor = json['store_card_bgcolor'].toString().replaceAll('#', '0xFF'),
        cardImageUrl = json['card_image'].toString(),
        storeCoverUrl = json['store_cover_image'].toString(),
        points = json['point'].toString();
}
