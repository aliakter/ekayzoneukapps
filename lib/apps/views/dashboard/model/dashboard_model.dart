import 'package:ekayzoneukapps/apps/views/home/models/ad_model.dart';

class DashboardModel {
  final int status;
  final bool success;
  final int code;
  final String message;
  final Data data;

  DashboardModel({
    required this.status,
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        status: json["status"],
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final AdsCount adsCount;
  final RecentAdd recentAdd;
  final DashBoardUser dashBoardUser;

  Data({
    required this.adsCount,
    required this.recentAdd,
    required this.dashBoardUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        adsCount: AdsCount.fromJson(json["ads_count"]),
        recentAdd: RecentAdd.fromJson(json["recent_ads"]),
        dashBoardUser: DashBoardUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "ads_count": adsCount.toJson(),
        "recent_ads": recentAdd.toJson(),
        "user": dashBoardUser.toJson(),
      };
}

class DashBoardUser {
  final int id;
  final String name;
  final String email;
  final String username;
  final int totalReview;
  final int averageReview;
  final DateTime createdAt;
  final dynamic country;
  final dynamic countryCode;
  final String imageUrl;
  final String image;

  DashBoardUser({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.totalReview,
    required this.averageReview,
    required this.createdAt,
    required this.country,
    required this.countryCode,
    required this.imageUrl,
    required this.image,
  });

  factory DashBoardUser.fromJson(Map<String, dynamic> json) => DashBoardUser(
        id: json["id"],
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        username: json["username"] ?? '',
        totalReview: json["total_review"],
        averageReview: json["average_review"],
        createdAt: DateTime.parse(json["created_at"]),
        country: json["country"] ?? '',
        countryCode: json["country_code"] ?? '',
        imageUrl: json["image_url"] ?? '',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "total_review": totalReview,
        "average_review": averageReview,
        "created_at": createdAt.toIso8601String(),
        "country": country,
        "country_code": countryCode,
        "image_url": imageUrl,
        "image": image,
      };
}

class AdsCount {
  final int postedAdsCount;
  final int activeAdsCount;
  final int expireAdsCount;
  final int pendingAdsCount;
  final int favouriteAdsCount;

  AdsCount({
    required this.postedAdsCount,
    required this.activeAdsCount,
    required this.expireAdsCount,
    required this.pendingAdsCount,
    required this.favouriteAdsCount,
  });

  factory AdsCount.fromJson(Map<String, dynamic> json) => AdsCount(
        postedAdsCount: json["posted_ads_count"],
        activeAdsCount: json["active_ads_count"],
        expireAdsCount: json["expire_ads_count"],
        pendingAdsCount: json["pending_ads_count"],
        favouriteAdsCount: json["favourite_ads_count"],
      );

  Map<String, dynamic> toJson() => {
        "posted_ads_count": postedAdsCount,
        "active_ads_count": activeAdsCount,
        "expire_ads_count": expireAdsCount,
        "pending_ads_count": pendingAdsCount,
        "favourite_ads_count": favouriteAdsCount,
      };
}

class Plan {
  final int adLimit;
  final int featuredLimit;
  final bool badge;
  final int eventLimit;
  final int businessDirectoryLimit;

  Plan({
    required this.adLimit,
    required this.featuredLimit,
    required this.badge,
    required this.eventLimit,
    required this.businessDirectoryLimit,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        adLimit: json["ad_limit"],
        featuredLimit: json["featured_limit"],
        badge: json["badge"],
        eventLimit: json["event_limit"],
        businessDirectoryLimit: json["business_directory_limit"],
      );

  Map<String, dynamic> toJson() => {
        "ad_limit": adLimit,
        "featured_limit": featuredLimit,
        "badge": badge,
        "event_limit": eventLimit,
        "business_directory_limit": businessDirectoryLimit,
      };
}

class RecentAdd {
  final int currentPage;
  final List<AdsModel> data;
  final String firstPageUrl;
  final int total;

  RecentAdd({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.total,
  });

  factory RecentAdd.fromJson(Map<String, dynamic> json) => RecentAdd(
        currentPage: json["current_page"],
        data: List<AdsModel>.from(json["data"].map((x) => AdsModel.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x)),
        "first_page_url": firstPageUrl,
        "total": total,
      };
}

class User {
  final String image;
  final String name;
  final String imageUrl;
  final int unread;

  User({
    required this.image,
    required this.name,
    required this.imageUrl,
    required this.unread,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        image: json["image"],
        name: json["name"],
        imageUrl: json["image_url"],
        unread: json["unread"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "image_url": imageUrl,
        "unread": unread,
      };
}

class Description {
  final String paginate;

  Description({
    required this.paginate,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        paginate: json["paginate"],
      );

  Map<String, dynamic> toJson() => {
        "paginate": paginate,
      };
}
