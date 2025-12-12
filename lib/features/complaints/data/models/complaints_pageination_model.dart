import 'package:complaint_app/features/complaints/data/models/comlaints_list_model.dart';
import 'package:complaint_app/features/complaints/domain/entities/complaints_pageination_entity.dart';

class ComplaintsPageModel extends ComplaintsPageEntity {
  const ComplaintsPageModel({
    required super.content,
    required super.page,
    required super.size,
    required super.totalElements,
    required super.totalPages,
    required super.hasNext,
    required super.hasPrevious,
  });

  factory ComplaintsPageModel.fromJson(Map<String, dynamic> json) {
    try {
      final List<ComplaintListModel> complaints = [];
      
      if (json['content'] != null && json['content'] is List) {
        try {
          complaints.addAll(
            (json['content'] as List).map((e) {
              try {
                if (e is Map<String, dynamic>) {
                  return ComplaintListModel.fromJson(e);
                } else {
                  return ComplaintListModel.fromJson(
                    Map<String, dynamic>.from(e),
                  );
                }
              } catch (e) {
                // Skip invalid complaint items
                return null;
              }
            }).whereType<ComplaintListModel>(),
          );
        } catch (e) {
          // If parsing fails, use empty list
          complaints.clear();
        }
      }

      return ComplaintsPageModel(
        content: complaints,
        page: (json['page'] as num?)?.toInt() ?? 0,
        size: (json['size'] as num?)?.toInt() ?? 10,
        totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
        totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
        hasNext: json['hasNext'] as bool? ?? false,
        hasPrevious: json['hasPrevious'] as bool? ?? false,
      );
    } catch (e) {
      // Return empty page model if parsing fails completely
      return ComplaintsPageModel(
        content: [],
        page: 0,
        size: 10,
        totalElements: 0,
        totalPages: 0,
        hasNext: false,
        hasPrevious: false,
      );
    }
  }
}
