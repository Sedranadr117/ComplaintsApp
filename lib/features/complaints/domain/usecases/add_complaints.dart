import 'package:complaint_app/features/complaints/domain/repositories/complaints_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/params/params.dart';
import '../entities/complaints_entity.dart';

class AddComplaint {
  final ComplaintRepository repository;

  AddComplaint({required this.repository});

  Future<Either<Failure, ComplaintEntity>> call({
    required AddComplaintParams params,
  }) {
    return repository.addComplaint(complaint: params);
  }
}
