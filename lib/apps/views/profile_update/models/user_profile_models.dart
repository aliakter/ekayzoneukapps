import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  int id;
  String name;
  String username;
  String email;
  String phone;
  dynamic emailVerifiedAt;
  dynamic web;
  String image;
  String token;
  dynamic lastSeen;
  String authType;
  dynamic provider;
  dynamic providerId;
  dynamic fcmToken;
  int totalAds;
  String location;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic zipcode;
  dynamic country;
  dynamic countryCode;
  dynamic ipAddress;
  dynamic timeZone;
  dynamic latitude;
  dynamic longitude;
  dynamic device;
  dynamic browser;
  int totalReview;
  dynamic averageReview;
  DateTime createdAt;
  dynamic updatedBy;
  DateTime updatedAt;
  dynamic createdBy;
  int status;
  String website;
  int showEmail;
  int showPhone;
  String imageUrl;

  UserProfileModel({
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
    required this.updatedAt,
    required this.status,
    required this.website,
    required this.showEmail,
    required this.showPhone,
    required this.imageUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        emailVerifiedAt: json["email_verified_at"],
        web: json["web"] ?? '',
        image: json["image"] ?? '',
        token: json["token"] ?? '',
        lastSeen: json["last_seen"] != null
            ? DateTime.parse(json["last_seen"])
            : DateTime.now(),
        authType: json["auth_type"] ?? '',
        provider: json["provider"],
        providerId: json["provider_id"],
        fcmToken: json["fcm_token"],
        totalAds: json["total_ads"],
        location: json["location"]??"",
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
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        website: json["website"] ?? '',
        showEmail: json["show_email"] ?? 0,
        showPhone: json["show_phone"] ?? 0,
        imageUrl: json["image_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "web": web,
        "image": image,
        "token": token,
        "last_seen": lastSeen,
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
