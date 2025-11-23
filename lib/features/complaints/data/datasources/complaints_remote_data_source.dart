import 'dart:convert';

import 'package:complaint_app/core/errors/error_model.dart';
import 'package:complaint_app/core/errors/exceptions.dart';
import 'package:complaint_app/features/complaints/data/models/complaints_model.dart';
import 'package:complaint_app/features/complaints/data/models/complaints_pageination_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../../../core/databases/api/api_consumer.dart';
import '../../../../../../core/databases/api/end_points.dart';
import '../../../../../../core/params/params.dart';
import 'package:path/path.dart' as path;

class ComplaintsRemoteDataSource {
  final ApiConsumer api;

  ComplaintsRemoteDataSource({required this.api});
  Future<ComplaintModel> getTemplate(TemplateParams params) async {
    final response = await api.get("${EndPoints.template}/${params.id}");
    return ComplaintModel.fromJson(response);
  }

  Future<ComplaintModel> addComplaint(
    AddComplaintParams complaint, {
    List<PlatformFile>? files,
  }) async {
    final formData = FormData();

    // أضف البيانات كـ JSON
    formData.fields.add(
      MapEntry(
        'data',
        jsonEncode({
          'complaintType': complaint.complaintType,
          'governorate': complaint.governorate,
          'governmentAgency': complaint.governmentAgency,
          'location': complaint.location,
          'description': complaint.description,
          'solutionSuggestion': complaint.solutionSuggestion,
          // حطي اسم الملفات فقط مثلا
        }),
      ),
    );

    // أضف الملفات مع تحديد نوع الـ MediaType
    if (files != null) {
      for (var file in files) {
        final ext = path.extension(file.name).toLowerCase();
        MediaType contentType;

        if (ext == '.png') {
          contentType = MediaType('image', 'png');
        } else if (ext == '.jpg' || ext == '.jpeg') {
          contentType = MediaType('image', 'jpeg');
        } else if (ext == '.pdf') {
          contentType = MediaType('application', 'pdf');
        } else {
          contentType = MediaType('application', 'octet-stream'); // fallback
        }

        formData.files.add(
          MapEntry(
            'files',
            await MultipartFile.fromFile(
              file.path!,
              filename: file.name,
              contentType: contentType,
            ),
          ),
        );
      }
    }

    final response = await api.post(
      EndPoints.complaints,
      data: formData,
      isFormData: true,
    );

    if (response == null) {
      throw ServerException(
        ErrorModel(errorMessage: "Empty response from server", status: 500),
      );
    }

    return ComplaintModel.fromJson(response);
  }

  Future<ComplaintsPageModel> getAllComplaints({
    int page = 0,
    int size = 10,
  }) async {
    final response = await api.get(
      EndPoints.complaints,
      queryParameters: {'page': page, 'size': size},
    );

    return ComplaintsPageModel.fromJson(response);
  }
}
