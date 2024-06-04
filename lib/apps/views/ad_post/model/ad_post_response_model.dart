import 'dart:convert';

AdPostResponseModel adPostResponseModelFromJson(String str) => AdPostResponseModel.fromJson(json.decode(str));

String adPostResponseModelToJson(AdPostResponseModel data) => json.encode(data.toJson());

class AdPostResponseModel {
  // String title;
  // String slug;
  // int userId;
  // String categoryId;
  // dynamic subcategoryId;
  // int orderId;
  // String description;
  // dynamic phone;
  // bool showPhone;
  // String email;
  // int showEmail;
  // dynamic whatsapp;
  // dynamic wpCountry;
  // int showWhatsapp;
  // dynamic phone2;
  // int featured;
  // int isBlocked;
  // dynamic address;
  // dynamic neighborhood;
  // String locality;
  // dynamic place;
  // String city;
  // String postcode;
  // String region;
  // String country;
  // String countryCode;
  // String long;
  // String lat;
  // dynamic metaKeywords;
  // dynamic metaDescription;
  // String authenticity;
  // String vehicleFuleType;
  // String textbookType;
  // String status;
  // int createdBy;
  // DateTime createdAt;
  // String employerLogo;
  // DateTime updatedAt;
  int id;
  // String imageUrl;
  // Category category;
  // Customer customer;
  // dynamic brand;
  // List<dynamic> adFeatures;
  // List<dynamic> galleries;

  AdPostResponseModel({
    // required this.title,
    // required this.slug,
    // required this.userId,
    // required this.categoryId,
    // required this.subcategoryId,
    // required this.orderId,
    // required this.description,
    // required this.phone,
    // required this.showPhone,
    // required this.email,
    // required this.showEmail,
    // required this.whatsapp,
    // required this.wpCountry,
    // required this.showWhatsapp,
    // required this.phone2,
    // required this.featured,
    // required this.isBlocked,
    // required this.address,
    // required this.neighborhood,
    // required this.locality,
    // required this.place,
    // required this.city,
    // required this.postcode,
    // required this.region,
    // required this.country,
    // required this.countryCode,
    // required this.long,
    // required this.lat,
    // required this.metaKeywords,
    // required this.metaDescription,
    // required this.authenticity,
    // required this.vehicleFuleType,
    // required this.textbookType,
    // required this.status,
    // required this.createdBy,
    // required this.createdAt,
    // required this.employerLogo,
    // required this.updatedAt,
    required this.id,
    // required this.imageUrl,
    // required this.category,
    // required this.customer,
    // required this.brand,
    // required this.adFeatures,
    // required this.galleries,
  });

  factory AdPostResponseModel.fromJson(Map<String, dynamic> json) => AdPostResponseModel(
    // title: json["title"],
    // slug: json["slug"],
    // userId: json["user_id"],
    // categoryId: json["category_id"],
    // subcategoryId: json["subcategory_id"],
    // orderId: json["order_id"],
    // description: json["description"],
    // phone: json["phone"],
    // showPhone: json["show_phone"],
    // email: json["email"],
    // showEmail: json["show_email"],
    // whatsapp: json["whatsapp"],
    // wpCountry: json["wp_country"],
    // showWhatsapp: json["show_whatsapp"],
    // phone2: json["phone_2"],
    // featured: json["featured"],
    // isBlocked: json["is_blocked"],
    // address: json["address"],
    // neighborhood: json["neighborhood"],
    // locality: json["locality"],
    // place: json["place"],
    // city: json["city"],
    // postcode: json["postcode"],
    // region: json["region"],
    // country: json["country"],
    // countryCode: json["country_code"],
    // long: json["long"],
    // lat: json["lat"],
    // metaKeywords: json["meta_keywords"],
    // metaDescription: json["meta_description"],
    // authenticity: json["authenticity"],
    // vehicleFuleType: json["vehicle_fule_type"],
    // textbookType: json["textbook_type"],
    // status: json["status"],
    // createdBy: json["created_by"],
    // createdAt: DateTime.parse(json["created_at"]),
    // employerLogo: json["employer_logo"],
    // updatedAt: DateTime.parse(json["updated_at"]),
    id: json["id"],
    // imageUrl: json["image_url"],
    // category: Category.fromJson(json["category"]),
    // customer: Customer.fromJson(json["customer"]),
    // brand: json["brand"],
    // adFeatures: List<dynamic>.from(json["ad_features"].map((x) => x)),
    // galleries: List<dynamic>.from(json["galleries"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    // "title": title,
    // "slug": slug,
    // "user_id": userId,
    // "category_id": categoryId,
    // "subcategory_id": subcategoryId,
    // "order_id": orderId,
    // "description": description,
    // "phone": phone,
    // "show_phone": showPhone,
    // "email": email,
    // "show_email": showEmail,
    // "whatsapp": whatsapp,
    // "wp_country": wpCountry,
    // "show_whatsapp": showWhatsapp,
    // "phone_2": phone2,
    // "featured": featured,
    // "is_blocked": isBlocked,
    // "address": address,
    // "neighborhood": neighborhood,
    // "locality": locality,
    // "place": place,
    // "city": city,
    // "postcode": postcode,
    // "region": region,
    // "country": country,
    // "country_code": countryCode,
    // "long": long,
    // "lat": lat,
    // "meta_keywords": metaKeywords,
    // "meta_description": metaDescription,
    // "authenticity": authenticity,
    // "vehicle_fule_type": vehicleFuleType,
    // "textbook_type": textbookType,
    // "status": status,
    // "created_by": createdBy,
    // "created_at": createdAt.toIso8601String(),
    // "employer_logo": employerLogo,
    // "updated_at": updatedAt.toIso8601String(),
    "id": id,
    // "image_url": imageUrl,
    // "category": category.toJson(),
    // "customer": customer.toJson(),
    // "brand": brand,
    // "ad_features": List<dynamic>.from(adFeatures.map((x) => x)),
    // "galleries": List<dynamic>.from(galleries.map((x) => x)),
  };
}

class Category {
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
  String imageUrl;
  List<Brand> brand;

  Category({
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
    required this.imageUrl,
    required this.brand,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
    imageUrl: json["image_url"],
    brand: List<Brand>.from(json["brand"].map((x) => Brand.fromJson(x))),
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
    "image_url": imageUrl,
    "brand": List<dynamic>.from(brand.map((x) => x.toJson())),
  };
}

class Brand {
  int id;
  int categoryId;
  int subcategoryId;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;

  Brand({
    required this.id,
    required this.categoryId,
    required this.subcategoryId,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    name: json["name"],
    slug: json["slug"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "name": name,
    "slug": slug,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Customer {
  int id;
  dynamic name;
  String username;
  String email;
  dynamic phone;
  DateTime emailVerifiedAt;
  dynamic web;
  String image;
  String token;
  DateTime lastSeen;
  String authType;
  dynamic provider;
  dynamic providerId;
  dynamic fcmToken;
  int totalAds;
  dynamic location;
  dynamic address;
  String city;
  String state;
  int zipcode;
  String country;
  String countryCode;
  String ipAddress;
  String timeZone;
  String latitude;
  String longitude;
  String device;
  String browser;
  int totalReview;
  int averageReview;
  DateTime createdAt;
  dynamic updatedBy;
  DateTime updatedAt;
  dynamic createdBy;
  int status;
  dynamic website;
  int showEmail;
  int showPhone;
  String imageUrl;

  Customer({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.web,
    required this.image,
    required this.token,
    required this.lastSeen,
    required this.authType,
    required this.provider,
    required this.providerId,
    required this.fcmToken,
    required this.totalAds,
    required this.location,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.country,
    required this.countryCode,
    required this.ipAddress,
    required this.timeZone,
    required this.latitude,
    required this.longitude,
    required this.device,
    required this.browser,
    required this.totalReview,
    required this.averageReview,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.createdBy,
    required this.status,
    required this.website,
    required this.showEmail,
    required this.showPhone,
    required this.imageUrl,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    web: json["web"],
    image: json["image"],
    token: json["token"],
    lastSeen: DateTime.parse(json["last_seen"]),
    authType: json["auth_type"],
    provider: json["provider"],
    providerId: json["provider_id"],
    fcmToken: json["fcm_token"],
    totalAds: json["total_ads"],
    location: json["location"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zipcode: json["zipcode"],
    country: json["country"],
    countryCode: json["country_code"],
    ipAddress: json["ip_address"],
    timeZone: json["time_zone"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    device: json["device"],
    browser: json["browser"],
    totalReview: json["total_review"],
    averageReview: json["average_review"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"],
    status: json["status"],
    website: json["website"],
    showEmail: json["show_email"],
    showPhone: json["show_phone"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "web": web,
    "image": image,
    "token": token,
    "last_seen": lastSeen.toIso8601String(),
    "auth_type": authType,
    "provider": provider,
    "provider_id": providerId,
    "fcm_token": fcmToken,
    "total_ads": totalAds,
    "location": location,
    "address": address,
    "city": city,
    "state": state,
    "zipcode": zipcode,
    "country": country,
    "country_code": countryCode,
    "ip_address": ipAddress,
    "time_zone": timeZone,
    "latitude": latitude,
    "longitude": longitude,
    "device": device,
    "browser": browser,
    "total_review": totalReview,
    "average_review": averageReview,
    "created_at": createdAt.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt.toIso8601String(),
    "created_by": createdBy,
    "status": status,
    "website": website,
    "show_email": showEmail,
    "show_phone": showPhone,
    "image_url": imageUrl,
  };
}
