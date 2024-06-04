import 'package:ekayzoneukapps/apps/data/data_source/remote_data_source.dart';
import 'package:ekayzoneukapps/apps/data/error/failure.dart';
import 'package:ekayzoneukapps/apps/views/my_ads/model/user_ads_model.dart';
import 'package:dartz/dartz.dart';
import '../../../data/error/exception.dart';

abstract class MyAdsRepository {
  Future<Either<Failure, UserAdModel>> getUserAdsData(String token, int index);
  Future<Either<Failure, String>> deleteAds(String token, String id);
}

class MyAdsRepositoryImpl extends MyAdsRepository {
  final RemoteDataSource remoteDataSource;
  MyAdsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserAdModel>> getUserAdsData(String token, int index) async {
    try {
      final result = await remoteDataSource.getUserAdsListData(token, index);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> deleteAds(String token, String id) async {
    try {
      final result = await remoteDataSource.deleteAds(token, id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
