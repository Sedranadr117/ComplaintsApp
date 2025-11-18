import 'package:complaint_app/features/complaints/data/models/complaints_model.dart';

import '../../../../../../core/databases/api/api_consumer.dart';
import '../../../../../../core/databases/api/end_points.dart';
import '../../../../../../core/params/params.dart';

class ComplaintsRemoteDataSource {
  final ApiConsumer api;

  ComplaintsRemoteDataSource({required this.api});
  Future<ComplaintModel> getTemplate(TemplateParams params) async {
    final response = await api.get("${EndPoints.template}/${params.id}");
    return ComplaintModel.fromJson(response);
  }

  Future<ComplaintModel> addComplaint(AddComplaintParams complaint) async {
    final response = await api.post(
      EndPoints.addComplaint,
      data: complaint.toJson(),
    );
    final complaintModel = ComplaintModel.fromJson(response);
    return complaintModel;
  }
}
