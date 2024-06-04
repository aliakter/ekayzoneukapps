import 'dart:convert';
import 'package:ekayzoneukapps/apps/views/home/models/brand_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/sub_category_model.dart';

class Category {
  final int id;
  final String name;
  // final dynamic slug;
  // final String icon;
  final dynamic order;
  // final dynamic image;
  // final List<Subcategory>? subcategories;
  // final List<BrandModel> brands;
  final bool hasCustomField;

  Category({
    required this.id,
    required this.name,
    // required this.slug,
    // required this.icon,
    required this.order,
    // required this.image,
    // this.subcategories,
    // required this.brands,
    required this.hasCustomField,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"] ?? "",
        // slug: json["slug"],
        // icon: json["icon"] ?? "",
        order: json["order"],
        // image: json["image"],
        // subcategories: json["subcategories"] == null
        //     ? null
        //     : List<Subcategory>.from(
        //         json["subcategories"].map((x) => Subcategory.fromMap(x))),
        // brands: json["brand"] == [] || json["brand"] == null
        //     ? []
        //     : List<BrandModel>.from(
        //         json["brand"].map((x) => BrandModel.fromMap(x))),
        hasCustomField: json["has_custom_field"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        // "slug": slug,
        // "icon": icon,
        "order": order,
        // "image": image,
        // "subcategories":
        //     List<dynamic>.from(subcategories!.map((x) => x.toMap())),
        // "brands": List<dynamic>.from(brands.map((x) => x.toMap())),
        "has_custom_field": hasCustomField,
      };
}
