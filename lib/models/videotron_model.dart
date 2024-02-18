class VideotronModel {
  int? id;
  int? categoryId;
  String? name;
  String? image;
  String? description;

  VideotronModel({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.description,
  });

  VideotronModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'image': image,
      'description': description,
    };
  }
}
