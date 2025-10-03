import 'package:flutter/material.dart';

class ActionListTile extends StatelessWidget {
  const ActionListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
          foregroundColor: theme.primaryColor,
          child: Icon(icon),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: trailing,
      ),
    );
  }
}
