// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:file_picker/file_picker.dart';

class TemplateParams {
  final String id;
  TemplateParams({required this.id});
}

class AuthParams {
  final String? id;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? role;

  AuthParams({
    this.id,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.role,
  });
}

class AddComplaintParams {
  final String complaintType;
  final String governorate;
  final String governmentAgency;
  final String location;
  final String description;
  final String solutionSuggestion;
  final List<PlatformFile> attachments;

  const AddComplaintParams({
    required this.complaintType,
    required this.governorate,
    required this.governmentAgency,
    required this.location,
    required this.description,
    required this.solutionSuggestion,
    required this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      "complaintType": complaintType,
      "governorate": governorate,
      "governmentAgency": governmentAgency,
      "location": location,
      "description": description,
      "solutionSuggestion": solutionSuggestion,
      "attachments": attachments,
    };
  }
}
