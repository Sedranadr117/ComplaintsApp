import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/params/params.dart';
import '../entities/complaints_entity.dart';

abstract class ComplaintRepository {
  Future<Either<Failure, ComplaintEntity>> getTemplate({
    required TemplateParams params,
  });
  Future<Either<Failure, ComplaintEntity>> addComplaint({
    required AddComplaintParams complaint,
  });
}
