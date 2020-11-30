class UserModel {
  String name;
  String email;
  final int id;
  String phone;
  String apiToken;
  String role;
  String profileImg;
  String points='0';
  String status;

  UserModel({
    this.name,
    this.email,
    this.id,
    this.phone,
    this.role,
    this.profileImg,
    this.apiToken,
    this.status,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        id = json['id'],
        email = json['email'].toString(),
        phone = json['mobile_number'].toString(),
        role = json['role'].toString(),
        status = json['status'].toString(),
        apiToken = json['api_token'].toString(),
        profileImg = json['profile_photo'].toString();
}
