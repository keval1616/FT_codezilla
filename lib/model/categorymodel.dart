class CategoryModel {
  String? category;

  CategoryModel({
    this.category,
  });

  CategoryModel.fromMap(Map<String, dynamic> json)
      : category = json["category"];

  Map<String, dynamic> toJson() => {
        'category': category,
      };
}
