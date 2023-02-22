

class UserModel {

   int? id;
   String? title;
   String? category;
   String? note;
   String? url;
   String? logo;
   String? image;

  UserModel({ required this.id,required this.title,required this.category,required this.note,required this.url,required this.logo,required this.image});

  Map<String, dynamic> toMap(){
    var map; <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["category"] = category;
    map["note"] = note;
    map["url"] = url;
    map["logo"] = logo;
    map["image"] = image;
    return map;

  }
  UserModel.fromMap(Map<dynamic, dynamic>map){
    id = map["id"];
    title = map["title"];
    category = map["category"];
    note = map["note"];
    url = map["url"];
    logo = map["logo"];
    image = map["image"];
  }


}