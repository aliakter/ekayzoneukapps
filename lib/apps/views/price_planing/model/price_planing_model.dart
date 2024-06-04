class PricePlaningModel {
  final int id;
  final String label;
  final int price;
  final int adLimit;
  final int featuredLimit;
  final bool badge;
  final int recommended;
  final int businessDirectoryLimit;
  final int eventLimit;
  final String cashPayment;

  PricePlaningModel({
    required this.id,
    required this.label,
    required this.price,
    required this.adLimit,
    required this.featuredLimit,
    required this.badge,
    required this.recommended,
    required this.businessDirectoryLimit,
    required this.eventLimit,
    required this.cashPayment,
  });

  factory PricePlaningModel.fromJson(Map<String, dynamic> json) => PricePlaningModel(
    id: json["id"],
    label: json["label"]??"",
    price: json["price"],
    adLimit: json["ad_limit"]??0,
    featuredLimit: json["featured_limit"]??0,
    badge: json["badge"]??false,
    recommended: json["recommended"]??0,
    businessDirectoryLimit: json["business_directory_limit"]??0,
    eventLimit: json["event_limit"]??0,
    cashPayment: json["cash_payment"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "price": price,
    "ad_limit": adLimit,
    "featured_limit": featuredLimit,
    "badge": badge,
    "recommended": recommended,
    "business_directory_limit": businessDirectoryLimit,
    "event_limit": eventLimit,
    "cash_payment": cashPayment,
  };
}
