import 'dart:convert';

class DesignationModel {
  int? id;
  String? title;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  DesignationModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory DesignationModel.fromRawJson(String str) => DesignationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DesignationModel.fromJson(Map<String, dynamic> json) => DesignationModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
  };
}
