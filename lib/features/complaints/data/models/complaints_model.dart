import 'package:complaint_app/features/complaints/domain/entities/complaints_entity.dart';

class ComplaintModel extends ComplaintEntity {
  const ComplaintModel({
    required super.complaintType,
    required super.governorate,
    required super.governmentAgency,
    required super.location,
    required super.description,
    required super.solutionSuggestion,
    required super.citizenId,
    required super.attachments,
  });

  /// fromJson
  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      complaintType: json['complaintType'],
      governorate: json['governorate'],
      governmentAgency: json['governmentAgency'],
      location: json['location'],
      description: json['description'],
      solutionSuggestion: json['solutionSuggestion'],
      citizenId: json['citizenId'],
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      "complaintType": complaintType,
      "governorate": governorate,
      "governmentAgency": governmentAgency,
      "location": location,
      "description": description,
      "solutionSuggestion": solutionSuggestion,
      "citizenId": citizenId,
      "attachments": attachments,
    };
  }
}
