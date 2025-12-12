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
    // Handle different attachment formats from the API
    List<String> parseAttachments(dynamic attachmentsData) {
      if (attachmentsData == null) return [];

      try {
        // If it's already a List<String>
        if (attachmentsData is List<String>) {
          return attachmentsData;
        }

        // If it's a List (could be List<dynamic>, List<Map>, etc.)
        if (attachmentsData is List) {
          final List<String> result = [];
          for (var item in attachmentsData) {
            if (item is String) {
              result.add(item);
            } else if (item is Map) {
              // Extract downloadUrl from map structure
              final Map<String, dynamic> mapItem = Map<String, dynamic>.from(
                item,
              );
              final url =
                  mapItem['downloadUrl'] as String? ??
                  mapItem['url'] as String?;
              if (url != null && url.isNotEmpty) {
                result.add(url);
              }
            }
          }
          return result;
        }

        // If it's a Map (single attachment or different structure)
        if (attachmentsData is Map) {
          final Map<String, dynamic> mapData = Map<String, dynamic>.from(
            attachmentsData,
          );
          // Try to extract URL
          final url =
              mapData['downloadUrl'] as String? ?? mapData['url'] as String?;
          if (url != null && url.isNotEmpty) {
            return [url];
          }
        }
      } catch (e) {
        // If parsing fails, return empty list
        return [];
      }

      return [];
    }

    return ComplaintModel(
      complaintType: json['complaintType'] as String? ?? '',
      governorate: json['governorate'] as String? ?? '',
      governmentAgency: json['governmentAgency'] as String? ?? '',
      location: json['location'] as String? ?? '',
      description: json['description'] as String? ?? '',
      solutionSuggestion: json['solutionSuggestion'] as String? ?? '',
      citizenId: json['citizenId'] as int? ?? 0,
      attachments: parseAttachments(json['attachments']),
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
