class StudentProfileModel {
    String? id;
    String? name;
    String? email;
    String? image;
    bool? isAdmin;
    String? grade;

  StudentProfileModel(this.id, this.name, this.email, this.image, this.isAdmin ,this.grade);


  StudentProfileModel.fromJson(Map<String,dynamic>? json){
    id = json!["id"];
    name = json["name"];
    email = json["email"];
    image = json["image"];
    isAdmin = json["isAdmin"];
    grade = json["grade"];
  }

    Map<String,dynamic> toMap() {
      return {
        "id": id,
        "isAdmin": isAdmin,
        "email": email,
        "name": name,
        "image": image,
        "grade": grade,

      };
    }

}