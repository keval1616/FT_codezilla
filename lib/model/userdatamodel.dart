
class DataModel {
  String? title;
  String? category;
  String? note;
  String? url;
  String? logo;
  String? image;

  DataModel({ this.title, this.category, this.note, this.url, this.logo,
    this.image});

  DataModel.fromMap(Map<String, dynamic>json)
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