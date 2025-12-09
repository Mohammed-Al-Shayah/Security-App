import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncidentDetailsDialog extends StatelessWidget {
  const IncidentDetailsDialog({
    super.key,
    required this.title,
    required this.type,
    required this.status,
    required this.project,
    required this.date,
    required this.description,
  });

  final String title;
  final String type;
  final String status;
  final String project;
  final String date;
  final String description;

  bool get _isResolved =>
      status.toLowerCase() == 'resolved' || status == 'منتهي';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان + زر إغلاق
            Row(
              children: [
                SizedBox(width: 24.w),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Incident Details',
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'View complete incident information',
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, size: 20.sp),
                  splashRadius: 20.r,
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Title + Status (مع badge بسيطة)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _LabeledValue(label: 'Title', value: title),
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _LabeledValue(
                        label: 'Status',
                        value: status,
                        alignRight: true,
                      ),
                      SizedBox(height: 4.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999.r),
                            color: _isResolved
                                ? Colors.green.withValues(alpha: 0.12)
                                : Colors.orange.withValues(alpha: 0.12),
                          ),
                          child: Text(
                            status,
                            style: textTheme.bodySmall?.copyWith(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: _isResolved ? Colors.green : Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            _LabeledValue(label: 'Type', value: type),
            SizedBox(height: 16.h),

            _LabeledValue(label: 'Project', value: project),
            SizedBox(height: 16.h),

            _LabeledValue(label: 'Date', value: date),
            SizedBox(height: 16.h),

            _LabeledValue(
              label: 'Description',
              value: description,
              maxLines: 4,
            ),

            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

class _LabeledValue extends StatelessWidget {
  const _LabeledValue({
    required this.label,
    required this.value,
    this.alignRight = false,
    this.maxLines,
  });

  final String label;
  final String value;
  final bool alignRight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextAlign textAlign = alignRight ? TextAlign.right : TextAlign.left;
    final CrossAxisAlignment crossAxisAlignment = alignRight
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontSize: 12.sp,
          ),
          textAlign: textAlign,
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: maxLines != null ? TextOverflow.ellipsis : null,
        ),
      ],
    );
  }
}

Future<void> showIncidentDetailsDialog(
  BuildContext context, {
  required String title,
  required String type,
  required String status,
  required String project,
  required String date,
  required String description,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => IncidentDetailsDialog(
      title: title,
      type: type,
      status: status,
      project: project,
      date: date,
      description: description,
    ),
  );
}
