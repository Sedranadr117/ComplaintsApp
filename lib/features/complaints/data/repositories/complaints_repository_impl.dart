import 'package:complaint_app/features/complaints/domain/entities/complaints_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/params/params.dart';
import '../../domain/repositories/complaints_repository.dart';
import '../datasources/complaints_remote_data_source.dart';

class ComplaintRepositoryImpl extends ComplaintRepository {
  final NetworkInfo networkInfo;
  final ComplaintsRemoteDataSource remoteDataSource;
  ComplaintRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, ComplaintEntity>> getTemplate({
    required TemplateParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTemplate = await remoteDataSource.getTemplate(params);
        return Right(remoteTemplate);
      } on ServerException catch (e) {
        return Left(
          Failure(
            errMessage: e.errorModel.errorMessage,
            statusCode: e.errorModel.status,
          ),
        );
      }
    } else {
      return Left(Failure(errMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ComplaintEntity>> addComplaint({
    required AddComplaintParams complaint,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteComplaint = await remoteDataSource.addComplaint(complaint);
        return Right(remoteComplaint);
      } on ServerException catch (e) {
        return Left(
          Failure(
            errMessage: e.errorModel.errorMessage,
            statusCode: e.errorModel.status,
          ),
        );
      }
    } else {
      return Left(Failure(errMessage: 'No internet connection'));
    }
  }
}
