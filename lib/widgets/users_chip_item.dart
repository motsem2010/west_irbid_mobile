import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/models/user_model.dart';

class UserChip extends StatelessWidget {
  final UserModel user;
  final void Function()? onDelete;

  const UserChip({required this.user, required this.onDelete});

  Color _avatarColorFor(String name) {
    final hash = name.codeUnits.fold<int>(0, (p, e) => p + e);
    final hue = (hash % 360).toDouble();
    return HSVColor.fromAHSV(1, hue, 0.55, 0.95).toColor();
  }

  Widget _buildAvatar(UserModel user) {
    final initials = (user.userName ?? 'mo').trim().isEmpty
        ? '?'
        : user.userName!
              .split(RegExp(r'\s+'))
              .take(2)
              .map((s) => s.isNotEmpty ? s[0].toUpperCase() : '')
              .join();
    return CircleAvatar(
      radius: 20,
      backgroundColor: _avatarColorFor(user.userName ?? ' '),
      foregroundColor: Colors.white,
      child: Text(
        initials!.isEmpty ? 'U' : initials,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipTheme = theme.chipTheme;

    return Chip(
      label: Text(user.userName ?? ' ', style: chipTheme.labelStyle),
      avatar: _buildAvatar(user),
      onDeleted: onDelete != null ? () => onDelete!() : null,
      deleteIconColor: chipTheme.deleteIconColor,
      deleteButtonTooltipMessage: 'Remove ${user.userName}',
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
