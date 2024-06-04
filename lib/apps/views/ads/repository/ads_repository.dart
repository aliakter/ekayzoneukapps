import 'package:ekayzoneukapps/apps/data/data_source/remote_data_source.dart';
import 'package:ekayzoneukapps/apps/data/error/exception.dart';
import 'package:ekayzoneukapps/apps/data/error/failure.dart';
import 'package:ekayzoneukapps/apps/global_widget/categories_model.dart';
import 'package:ekayzoneukapps/apps/global_widget/settings_model.dart';
import 'package:ekayzoneukapps/apps/views/ad_details/model/ad_details_model.dart';
import 'package:ekayzoneukapps/apps/views/ads/model/adlist_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:ekayzoneukapps/apps/views/ads_edit/model/ad_edit_model.dart';

abstract class AdRepository {
  Future<Either<Failure, AdListResponseModel>> getAdsListData(
      String token,
      String searchText,
      String location,
      String selectedCity,
      String minPrice,
      String maxPrice,
      String sortingValue,
      String categoryValue,
      String page);

  Future<Either<Failure, AdDetailsModel>> getAdDetails(
      String token, String slug);

  Future<Either<Failure, String>> postAds(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, String>> paypalPaymentSuccess(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, String>> postReport(
      String token, Map<String, dynamic> body);

  Future<Either<Failure, String>> updateAds(
      String token, Map<String, dynamic> body, String id);

  Future<Either<Failure, AdEditModel>> getAdEditData(String token, String id);

  Future<Either<Failure, CategoriesModel>> getCategoriesData(String token);

  Future<Either<Failure, SettingsModel>> getSettingsData(String token);
}

class AdRepositoryImpl extends AdRepository {
  final RemoteDataSource remoteDataSource;

  AdRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AdListResponseModel>> getAdsListData(
      String token,
      String searchText,
      String location,
      String selectedCity,
      String minPrice,
      String maxPrice,
      String sortingValue,
      String categoryValue,
      String page) async {
    try {
      final result = await remoteDataSource.getAdsListData(
          token,
          searchText,
          location,
          selectedCity,
          minPrice,
          maxPrice,
          sortingValue,
          categoryValue,
          page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AdDetailsModel>> getAdDetails(
      String token, String slug) async {
    try {
      final result = await remoteDataSource.getAdDetails(token, slug);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AdEditModel>> getAdEditData(
      String token, String id) async {
    try {
      final result = await remoteDataSource.getAdEditData(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CategoriesModel>> getCategoriesData(
      String token) async {
    try {
      final result = await remoteDataSource.getCategoriesData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettingsData(String token) async {
    try {
      final result = await remoteDataSource.getSettingsData(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> postAds(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.postAds(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> paypalPaymentSuccess(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.paypalPaymentSuccess(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> postReport(
      String token, Map<String, dynamic> body) async {
    try {
      final result = await remoteDataSource.postReport(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> updateAds(
      String token, Map<String, dynamic> body, String id) async {
    try {
      final result = await remoteDataSource.updateAds(token, body, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
