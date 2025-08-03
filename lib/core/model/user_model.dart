/// Represents a user model with various attributes.
class UserModel {
  UserModel({
    this.sId,
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id']?.toString();
    id = json['id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    photoUrl = json['photoUrl']?.toString();
    token = json['token']?.toString();
  }
  String? sId;
  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? token;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['token'] = token;
    return data;
  }
}
