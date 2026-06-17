import 'package:devbid/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MessageListItem extends StatelessWidget {
  const MessageListItem({
    super.key,
    required this.name,
    required this.message,
    required this.onTap,
  });

  final String name;
  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
      tileColor: AppColors.surface,
      title: Text(name),
      subtitle: Text(message, style: const TextStyle(color: AppColors.textSecondary)),
      leading: const CircleAvatar(backgroundColor: AppColors.surfaceMuted),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
