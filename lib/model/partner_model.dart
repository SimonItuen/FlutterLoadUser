class PartnersModel {
  final String id;
  final String title;
  final String image;


  PartnersModel({
    this.id, this.title, this.image});

  PartnersModel.fromJson(Map<String, dynamic> json)
      : id= json['id'].toString(),
        image = json['image'].toString(),
        title = json['title'].toString();

}
