import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum StatusType { success, warning, danger, info, neutral }

class StatusChip extends StatelessWidget {
  final String label;
  final StatusType type;
  const StatusChip({super.key, required this.label, required this.type});

  Color get _bg {
    switch (type) {
      case StatusType.success:
        return AppColors.success.withOpacity(0.12);
      case StatusType.warning:
        return AppColors.warning.withOpacity(0.14);
      case StatusType.danger:
        return AppColors.danger.withOpacity(0.12);
      case StatusType.info:
        return AppColors.info.withOpacity(0.12);
      case StatusType.neutral:
        return AppColors.divider;
    }
  }

  Color get _fg {
    switch (type) {
      case StatusType.success:
        return AppColors.success;
      case StatusType.warning:
        return AppColors.warning;
      case StatusType.danger:
        return AppColors.danger;
      case StatusType.info:
        return AppColors.info;
      case StatusType.neutral:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _fg,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Geist',
              color: _fg,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
