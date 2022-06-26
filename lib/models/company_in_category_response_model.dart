import "dart:convert";

List<companyIncategoryResponseModel> companyIncategoryResponseModelJson(str) {
  List jsonResponse = json.decode(str);
  return jsonResponse
      .map((data) => companyIncategoryResponseModel.fromJson(data))
      .toList();
}

class companyIncategoryResponseModel {
  int? id;
  int? categoryId;
  String? name;
  String? slug;
  String? image;
  String? excerpt;
  String? desc;
  String? createdAt;
  String? updatedAt;

  companyIncategoryResponseModel(
      {this.id,
      this.categoryId,
      this.name,
      this.slug,
      this.image,
      this.excerpt,
      this.desc,
      this.createdAt,
      this.updatedAt});

  companyIncategoryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['company_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    excerpt = json['excerpt'];
    desc = json['desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['company_id'] = categoryId;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['excerpt'] = excerpt;
    data['desc'] = desc;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
