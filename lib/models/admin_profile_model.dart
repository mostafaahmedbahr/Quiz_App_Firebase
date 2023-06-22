class AdminProfileModel {
  String? id;
  String? name;
  String? email;
  String? image;
  bool? isAdmin;
  String? code;

  AdminProfileModel(this.id, this.name, this.email, this.image, this.isAdmin ,this.code);


  AdminProfileModel.fromJson(Map<String,dynamic>? json){
    id = json!["id"];
    name = json["name"];
    email = json["email"];
    image = json["image"];
    isAdmin = json["isAdmin"];
    code = json["code"];
  }

  Map<String,dynamic> toMap() {
    return {
      "id": id,
      "isAdmin": isAdmin,
      "email": email,
      "name": name,
      "image": image,
      "code": code,

    };
  }

}