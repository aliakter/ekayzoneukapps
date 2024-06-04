import 'dart:convert';

import 'package:ekayzoneukapps/apps/views/ad_details/model/ad_details_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/category_model.dart';
import 'package:ekayzoneukapps/apps/views/home/models/sub_category_model.dart';

import '../../home/models/customer_model.dart';

class AdEditModel {
  int? id;
  String? title;
  dynamic userName;
  String? slug;
  int? userId;
  String model;
  int? categoryId;
  int? subcategoryId;
  dynamic brandId;
  dynamic price;
  dynamic priceSymbol;
  String? description;
  dynamic phone;
  String? email;
  int? showEmail;
  bool? showPhone;
  dynamic phone2;
  dynamic thumbnail;
  int? featured;
  int? totalReports;
  int? totalViews;
  int? isBlocked;
  dynamic whatsapp;
  dynamic wpCountry;
  dynamic whatsappPhoneCode;
  int? showWhatsapp;
  String? status;
  int? orderId;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic authenticity;
  String edition;
  String? locality;
  dynamic neighborhood;
  dynamic address;
  String? postcode;
  dynamic place;
  String? city;
  String? region;
  String? country;
  String? countryCode;
  double? long;
  double? lat;
  int? isPromoted;
  dynamic draftedAt;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  dynamic updatedBy;
  dynamic adsType;
  dynamic propertySize;
  String? propertyUnit;
  dynamic vehicleManufacture;
  dynamic vehicleEngineCapacity;
  String? vehicleFuleType;
  dynamic vehicleTransmission;
  dynamic vehicleBodyType;
  String? propertyPriceType;
  dynamic propertyType;
  dynamic condition;
  dynamic registrationYear;
  dynamic featureDuration;
  dynamic designation;
  dynamic experience;
  dynamic jobType;
  dynamic requiredEducation;
  dynamic salaryFrom;
  dynamic salaryTo;
  dynamic deadline;
  dynamic employerName;
  dynamic website;
  dynamic employerLogo;
  dynamic textbookType;
  dynamic receiveIsEmail;
  dynamic receiveIsPhone;
  dynamic employerEmail;
  dynamic employerPhone;
  dynamic isRestricted;
  dynamic restrictDetails;
  dynamic restrictType;
  String? imageUrl;
  Category? category;
  Subcategory? subcategory;
  Customer? customer;
  dynamic brand;
  List<AdFeature>? adFeatures;
  List<Gallery>? galleries;

  AdEditModel({
    this.id,
    this.title,
    this.userName,
    this.slug,
    this.userId,
    required this.model,
    this.categoryId,
    this.subcategoryId,
    this.brandId,
    this.price,
    this.priceSymbol,
    this.description,
    this.phone,
    this.email,
    this.showEmail,
    this.showPhone,
    this.phone2,
    this.thumbnail,
    this.featured,
    this.totalReports,
    this.totalViews,
    this.isBlocked,
    this.whatsapp,
    this.wpCountry,
    this.whatsappPhoneCode,
    this.showWhatsapp,
    this.status,
    this.orderId,
    this.metaKeywords,
    this.metaDescription,
    this.authenticity,
    required this.edition,
    this.locality,
    this.neighborhood,
    this.address,
    this.postcode,
    this.place,
    this.city,
    this.region,
    this.country,
    this.countryCode,
    this.long,
    this.lat,
    this.isPromoted,
    this.draftedAt,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.adsType,
    this.propertySize,
    this.propertyUnit,
    this.vehicleManufacture,
    this.vehicleEngineCapacity,
    this.vehicleFuleType,
    this.vehicleTransmission,
    this.vehicleBodyType,
    this.propertyPriceType,
    this.propertyType,
    this.condition,
    this.registrationYear,
    this.featureDuration,
    this.designation,
    this.experience,
    this.jobType,
    this.requiredEducation,
    this.salaryFrom,
    this.salaryTo,
    this.deadline,
    this.employerName,
    this.website,
    this.employerLogo,
    this.textbookType,
    this.receiveIsEmail,
    this.receiveIsPhone,
    this.employerEmail,
    this.employerPhone,
    this.isRestricted,
    this.restrictDetails,
    this.restrictType,
    this.imageUrl,
    this.category,
    this.subcategory,
    this.customer,
    this.brand,
    this.adFeatures,
    this.galleries,
  });

  factory AdEditModel.fromRawJson(String str) =>
      AdEditModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdEditModel.fromJson(Map<String, dynamic> json) => AdEditModel(
        id: json["id"],
        title: json["title"],
        userName: json["user_name"],
        slug: json["slug"],
        userId: json["user_id"],
        model: json["model"] ?? '',
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"] ?? 0,
        brandId: json["brand_id"],
        price: json["price"],
        priceSymbol: json["price_symbol"],
        description: json["description"],
        phone: json["phone"],
        email: json["email"],
        showEmail: json["show_email"],
        showPhone: json["show_phone"],
        phone2: json["phone_2"],
        thumbnail: json["thumbnail"],
        featured: json["featured"],
        totalReports: json["total_reports"],
        totalViews: json["total_views"],
        isBlocked: json["is_blocked"],
        whatsapp: json["whatsapp"],
        wpCountry: json["wp_country"],
        whatsappPhoneCode: json["whatsapp_phone_code"],
        showWhatsapp: json["show_whatsapp"],
        status: json["status"] is int
            ? json["status"].toString()
            : json["status"] ?? "",
        orderId: json["order_id"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        authenticity: json["authenticity"],
        edition: json["edition"] ?? '',
        locality: json["locality"],
        neighborhood: json["neighborhood"],
        address: json["address"],
        postcode: json["postcode"],
        place: json["place"],
        city: json["city"],
        region: json["region"],
        country: json["country"],
        countryCode: json["country_code"],
        long: json["long"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        isPromoted: json["is_promoted"],
        draftedAt: json["drafted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        adsType: json["ads_type"],
        propertySize: json["property_size"],
        propertyUnit: json["property_unit"],
        vehicleManufacture: json["vehicle_manufacture"],
        vehicleEngineCapacity: json["vehicle_engine_capacity"],
        vehicleFuleType: json["vehicle_fule_type"],
        vehicleTransmission: json["vehicle_transmission"],
        vehicleBodyType: json["vehicle_body_type"],
        propertyPriceType: json["property_price_type"],
        propertyType: json["property_type"],
        condition: json["condition"],
        registrationYear: json["registration_year"],
        featureDuration: json["feature_duration"],
        designation: json["designation"],
        experience: json["experience"],
        jobType: json["job_type"],
        requiredEducation: json["required_education"],
        salaryFrom: json["salary_from"],
        salaryTo: json["salary_to"],
        deadline: json["deadline"],
        employerName: json["employer_name"],
        website: json["website"],
        employerLogo: json["employer_logo"],
        textbookType: json["textbook_type"],
        receiveIsEmail: json["receive_is_email"],
        receiveIsPhone: json["receive_is_phone"],
        employerEmail: json["employer_email"],
        employerPhone: json["employer_phone"],
        isRestricted: json["is_restricted"],
        restrictDetails: json["restrict_details"],
        restrictType: json["restrict_type"],
        imageUrl: json["image_url"],
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Subcategory.fromMap(json["subcategory"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromMap(json["customer"]),
        brand: json["brand"],
        adFeatures: json["ad_features"] == null
            ? []
            : List<AdFeature>.from(
                json["ad_features"]!.map((x) => AdFeature.fromMap(x))),
        galleries: json["galleries"] == null
            ? []
            : List<Gallery>.from(
                json["galleries"]!.map((x) => Gallery.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "user_name": userName,
        "slug": slug,
        "user_id": userId,
        "model": model,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "brand_id": brandId,
        "price": price,
        "price_symbol": priceSymbol,
        "description": description,
        "phone": phone,
        "email": email,
        "show_email": showEmail,
        "show_phone": showPhone,
        "phone_2": phone2,
        "thumbnail": thumbnail,
        "featured": featured,
        "total_reports": totalReports,
        "total_views": totalViews,
        "is_blocked": isBlocked,
        "whatsapp": whatsapp,
        "wp_country": wpCountry,
        "whatsapp_phone_code": whatsappPhoneCode,
        "show_whatsapp": showWhatsapp,
        "status": status,
        "order_id": orderId,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "authenticity": authenticity,
        "edition": edition,
        "locality": locality,
        "neighborhood": neighborhood,
        "address": address,
        "postcode": postcode,
        "place": place,
        "city": city,
        "region": region,
        "country": country,
        "country_code": countryCode,
        "long": long,
        "lat": lat,
        "is_promoted": isPromoted,
        "drafted_at": draftedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "ads_type": adsType,
        "property_size": propertySize,
        "property_unit": propertyUnit,
        "vehicle_manufacture": vehicleManufacture,
        "vehicle_engine_capacity": vehicleEngineCapacity,
        "vehicle_fule_type": vehicleFuleType,
        "vehicle_transmission": vehicleTransmission,
        "vehicle_body_type": vehicleBodyType,
        "property_price_type": propertyPriceType,
        "property_type": propertyType,
        "condition": condition,
        "registration_year": registrationYear,
        "feature_duration": featureDuration,
        "designation": designation,
        "experience": experience,
        "job_type": jobType,
        "required_education": requiredEducation,
        "salary_from": salaryFrom,
        "salary_to": salaryTo,
        "deadline": deadline,
        "employer_name": employerName,
        "website": website,
        "employer_logo": employerLogo,
        "textbook_type": textbookType,
        "receive_is_email": receiveIsEmail,
        "receive_is_phone": receiveIsPhone,
        "employer_email": employerEmail,
        "employer_phone": employerPhone,
        "is_restricted": isRestricted,
        "restrict_details": restrictDetails,
        "restrict_type": restrictType,
        "image_url": imageUrl,
        "category": category?.toMap(),
        "subcategory": subcategory?.toMap(),
        "customer": customer?.toMap(),
        "brand": brand,
        "ad_features": adFeatures == null
            ? []
            : List<dynamic>.from(adFeatures!.map((x) => x)),
        "galleries": galleries == null
            ? []
            : List<dynamic>.from(galleries!.map((x) => x)),
      };
}
