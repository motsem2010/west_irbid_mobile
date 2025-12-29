import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/models/user_model.dart';

class UserChip2 extends StatelessWidget {
  final UserModel user;
  final void Function()? onDelete;

  const UserChip2({super.key, required this.user, required this.onDelete});

  Color _avatarColorFor(String name) {
    final hash = name.codeUnits.fold<int>(0, (p, e) => p + e);
    final hue = (hash % 360).toDouble();
    return HSVColor.fromAHSV(1, hue, 0.55, 0.95).toColor();
  }

  Widget _buildAvatar(UserModel user) {
    final displayName = user.userName ?? '';
    String initials;
    if (displayName.trim().isEmpty) {
      initials = '?';
    } else {
      final parts = displayName.split(RegExp(r'\s+'));
      initials = parts
          .where((part) => part.isNotEmpty)
          .take(2)
          .map((part) => part[0].toUpperCase())
          .join();
      if (initials.isEmpty) {
        initials = 'U';
      }
    }
    return CircleAvatar(
      radius: 16,
      backgroundColor: _avatarColorFor(displayName),
      foregroundColor: Colors.white,
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final displayName = user.userName ?? 'Unknown';

    return Chip(
      label: Text(
        displayName,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      avatar: _buildAvatar(user),
      onDeleted: onDelete,
      deleteIcon: Icon(
        Icons.close_rounded,
        color: colorScheme.onSurfaceVariant,
        size: 18,
      ),
      deleteButtonTooltipMessage: 'Remove $displayName',
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      elevation: 1,
      shadowColor: colorScheme.shadow,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      clipBehavior: Clip.antiAlias,
    );
  }
}
