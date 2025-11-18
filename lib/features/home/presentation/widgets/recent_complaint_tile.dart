import 'package:complaint_app/config/extensions/theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecentComplaintTile extends StatelessWidget {
  final Complaint complaint;

  const RecentComplaintTile({super.key, required this.complaint});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 13.h,
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            // Colored Stripe on the Right (for RTL)
            Container(
              width: 1.5.w,
              decoration: BoxDecoration(
                color: complaint.statusColor(context),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Type and Status (Top Row)
                    Row(
                      textDirection: TextDirection.ltr,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Status Badge (حالتها)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: complaint
                                .statusColor(context)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            complaint.statusText,
                            style: context.text.bodyMedium!.copyWith(
                              color: complaint.statusColor(context),
                              fontWeight: FontWeight.bold,
                              fontSize: 9.sp,
                            ),
                          ),
                        ),
                        // Complaint Type (نوعها)
                        Text(
                          'النوع: ${complaint.type}',
                          style: context.text.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            color: context.colors.onSurface,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),

                    // Entity and Date
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الجهة: ${complaint.entity}',
                        style: context.text.bodyMedium!.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),

                    SizedBox(height: 0.5.h),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'التاريخ: ${complaint.date.toLocal().toString().split(' ')[0]}',
                        style: context.text.bodyMedium!.copyWith(
                          color: context.colors.onSurfaceVariant,
                          fontSize: 10.sp,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Complaint {
  final String type;
  final String entity;
  final DateTime date;
  final ComplaintStatus status;

  Complaint({
    required this.type,
    required this.entity,
    required this.date,
    required this.status,
  });

  String get statusText {
    switch (status) {
      case ComplaintStatus.newComplaint:
        return 'جديدة';
      case ComplaintStatus.inReview:
        return 'قيد المراجعة';
      case ComplaintStatus.completed:
        return 'مكتملة';
      case ComplaintStatus.rejected:
        return 'مرفوضة';
    }
  }

  // تم تعديل الدالة لتستقبل BuildContext كـ parameter
  Color statusColor(BuildContext context) {
    // Accessing colors via context.colors using the passed context
    switch (status) {
      case ComplaintStatus.newComplaint:
        return const Color(0xFF3B7C88);
      case ComplaintStatus.inReview:
        return const Color(0xFFE6A43B);
      case ComplaintStatus.completed:
        return const Color(0xFF1FAC82);
      case ComplaintStatus.rejected:
        return const Color(0xFFD75454);
    }
  }
}

enum ComplaintStatus { newComplaint, inReview, completed, rejected }
