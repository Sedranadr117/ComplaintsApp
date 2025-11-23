import 'package:complaint_app/features/complaints/domain/entities/comlaints_list_entity.dart';

class ComplaintListModel extends ComplaintListEntity {
  const ComplaintListModel({
    required super.id,
    required super.complaintType,
    required super.governorate,
    required super.governmentAgency,
    required super.location,
    required super.description,
    required super.solutionSuggestion,
    required super.status,
    super.response,
    super.respondedAt,
    super.respondedById,
    super.respondedByName,
    required super.attachments,
    required super.citizenId,
    required super.citizenName,
    super.createdAt,
    super.updatedAt,
  });

  factory ComplaintListModel.fromJson(Map<String, dynamic> json) {
    return ComplaintListModel(
      id: json['id'],
      complaintType: json['complaintType'],
      governorate: json['governorate'],
      governmentAgency: json['governmentAgency'],
      location: json['location'],
      description: json['description'],
      solutionSuggestion: json['solutionSuggestion'],
      status: json['status'],
      response: json['response'],
      respondedAt: json['respondedAt'],
      respondedById: json['respondedById'],
      respondedByName: json['respondedByName'],
      attachments: List<String>.from(json['attachments'] ?? []),
      citizenId: json['citizenId'],
      citizenName: json['citizenName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
