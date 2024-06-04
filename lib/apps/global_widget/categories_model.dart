import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  List<Categories> categories;
  List<Designations> designations;
  List<Plannings> plans;

  CategoriesModel({
    required this.categories,
    required this.designations,
    required this.plans,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        categories: List<Categories>.from(
            json["categories"].map((x) => Categories.fromJson(x))),
        designations: List<Designations>.from(
            json["designations"].map((x) => Designations.fromJson(x))),
        plans: List<Plannings>.from(
            json["plans"].map((x) => Plannings.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "designations": List<dynamic>.from(designations.map((x) => x.toJson())),
        "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
      };
}

class Categories {
  int id;
  String name;
  String image;
  String slug;
  String icon;
  int order;
  int status;
  int totalViews;
  DateTime createdAt;
  DateTime updatedAt;
  int totalAd;
  dynamic createdBy;
  dynamic updatedBy;
  int adCount;
  String imageUrl;
  List<Branding> brand;
  List<Branding> subcategories;

  Categories({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
    required this.icon,
    required this.order,
    required this.status,
    required this.totalViews,
    required this.createdAt,
    required this.updatedAt,
    required this.totalAd,
    required this.createdBy,
    required this.updatedBy,
    required this.adCount,
    required this.imageUrl,
    required this.brand,
    required this.subcategories,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        slug: json["slug"],
        icon: json["icon"],
        order: json["order"],
        status: json["status"],
        totalViews: json["total_views"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        totalAd: json["total_ad"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        adCount: json["ad_count"],
        imageUrl: json["image_url"],
        brand: List<Branding>.from(json["brand"].map((x) => Branding.fromJson(x))),
        subcategories: List<Branding>.from(
            json["subcategories"].map((x) => Branding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "slug": slug,
        "icon": icon,
        "order": order,
        "status": status,
        "total_views": totalViews,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "total_ad": totalAd,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ad_count": adCount,
        "image_url": imageUrl,
        "brand": List<dynamic>.from(brand.map((x) => x.toJson())),
        "subcategories":
            List<dynamic>.from(subcategories.map((x) => x.toJson())),
      };
}

class Branding {
  int id;
  int categoryId;
  int subcategoryId;
  String name;
  String slug;

  // DateTime createdAt;
  // DateTime updatedAt;
  int status;
  int totalViews;

  Branding({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.name,
    required this.slug,
    // required this.createdAt,
    // required this.updatedAt,
    required this.status,
    required this.totalViews,
  });

  factory Branding.fromJson(Map<String, dynamic> json) => Branding(
        id: json["id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"] ?? 0,
        name: json["name"],
        slug: json["slug"],
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"] ?? 0,
        totalViews: json["total_views"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "name": name,
        "slug": slug,
        // "created_at": createdAt.toIso8601String(),
        // "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "total_views": totalViews,
      };
}

class Designations {
  int id;
  String title;
  dynamic description;
  int status;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic createdBy;
  dynamic updatedBy;

  Designations({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory Designations.fromJson(Map<String, dynamic> json) => Designations(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}

class Plannings {
  int id;
  String title;
  int price;
  int duration;

  Plannings({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
  });

  factory Plannings.fromJson(Map<String, dynamic> json) => Plannings(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "duration": duration,
      };
}
