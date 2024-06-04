import 'package:ekayzoneukapps/apps/views/home/models/ad_model.dart';

class WishlistModel {
  final int status;
  final bool success;
  final int code;
  final String message;
  final List<Datum> data;

  WishlistModel({
    required this.status,
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        status: json["status"],
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final int adId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AdsModel? ad;

  Datum({
    required this.id,
    required this.adId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.ad,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        adId: json["ad_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ad: json['ad'] == null ? null : AdsModel.fromMap(json["ad"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ad_id": adId,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "ad": ad!.toMap(),
      };
}
