import 'dart:convert';

List<categoryResponseModel> categoryResponseJson(str) {
  List jsonResponse = json.decode(str);
  return jsonResponse.map((data) => categoryResponseModel.fromJson(data)).toList();
}

class categoryResponseModel {
  categoryResponseModel({
    required this.id,
    required this.name,
    required this.slug,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String slug;
  String? createdAt;
  String? updatedAt;

  categoryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    //final _data = <String, dynamic>{};
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['id'] = id;
    _data['name'] = name;
    _data['slug'] = slug;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
