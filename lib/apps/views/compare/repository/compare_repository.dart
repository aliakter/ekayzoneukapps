import 'package:ekayzoneukapps/apps/data/data_source/remote_data_source.dart';
import 'package:ekayzoneukapps/apps/data/error/failure.dart';
import 'package:ekayzoneukapps/apps/views/compare/model/compare_list_model.dart';
import 'package:dartz/dartz.dart';
import '../../../data/error/exception.dart';

abstract class CompareRepository {
  Future<Either<Failure, CompareListModel>> getCompareList();
}

class CompareRepositoryImpl extends CompareRepository {
  final RemoteDataSource remoteDataSource;
  CompareRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CompareListModel>> getCompareList() async {
    try {
      final result = await remoteDataSource.getCompareListData();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
