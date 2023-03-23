






class UserModel {


  String? title;
  String? category;
  String? note;
  String? url;
  String? logo;
  String? image;

  UserModel({this.title, this.category, this.note, this.url, this.logo,
      this.image});

  UserModel.fromJson(Map<String, dynamic>json)
      :
        title = json["title"],
        category = json["category"],
        note = json["note"],
        url = json["url"],
        logo = json["logo"],
        image = json["image"];

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'category': category,
        'note': note,
        'url': url,
        'logo': logo,
        'image': image
      };
}



  // Map<String, dynamic> toMap(){
  //   var map; <String, dynamic>{};
  //
  //   map["title"] = title;
  //   map["category"] = category;
  //   map["note"] = note;
  //   map["url"] = url;
  //   map["logo"] = logo;
  //   map["image"] = image;
  //   return map;
  //
  // }
  // UserModel.fromMap(Map<dynamic, dynamic>map){
  //
  //   title = map["title"];
  //   category = map["category"];
  //   note = map["note"];
  //   url = map["url"];
  //   logo = map["logo"];
  //   image = map["image"];
  // }


// }
// class UserModel {
//   Data? data;
//
//   UserModel({this.data});
//   UserModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
// class Data{
//   List<Records>? records;
//   Data({this.records});
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['records'] != null) {
//       records = <Records>[];
//       json['records'].forEach((v) {
//         records!.add(new Records.fromJson(v));
//       });
//     }
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.records != null) {
//       data['records'] = this.records!.map((v) => v.toJson()).toList();
//     }
//
//     return data;
//   }
// }
// class Records {
//
//   String? title;
//   String? category;
//   String? note;
//   String? url;
//   String? logo;
//   String? image;
//
//   Records({this.title,this.url,this.note,this.category,this.image,this.logo});
//
//   Records.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     category = json['category'];
//     note = json['note'];
//     url = json['url'];
//     image = json['image'];
//     logo = json['logo'];
//
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['category'] = this.category;
//     data['note'] = this.note;
//     data['url'] = this.url;
//     data['image'] = this.image;
//     data['logo'] = this.logo;
//
//     return data;
//   }
//
// }