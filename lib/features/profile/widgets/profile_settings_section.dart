import 'package:flutter/material.dart';

class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({
    super.key,
    required this.onMyProjectsTap,
    required this.onAttendanceHistoryTap,
    required this.onLanguageTap,
    required this.onLogoutTap,
    this.currentLanguage = 'English',
  });

  final VoidCallback onMyProjectsTap;
  final VoidCallback onAttendanceHistoryTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onLogoutTap;
  final String currentLanguage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Cards section
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              SettingsTile(
                icon: Icons.folder_outlined,
                title: 'My Projects',
                onTap: onMyProjectsTap,
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.receipt_long_outlined,
                title: 'Attendance History',
                onTap: onAttendanceHistoryTap,
                showTrailingChevron: true,
              ),
              const Divider(height: 1),
              SettingsTile(
                icon: Icons.language,
                title: 'Language',
                trailingText: currentLanguage,
                onTap: onLanguageTap,
                showTrailingChevron: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Logout button
        LogoutButton(onTap: onLogoutTap),
      ],
    );
  }
}

/// صف واحد في الإعدادات
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.onTap,
    this.showTrailingChevron = false,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool showTrailingChevron;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 20, color: theme.iconTheme.color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailingText != null) ...<Widget>[
              Text(
                trailingText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 8),
            ],
            if (showTrailingChevron)
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

/// زر تسجيل الخروج
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color danger = theme.colorScheme.error;

    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(Icons.logout, size: 18, color: danger),
      label: Text(
        'Logout',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: danger,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: danger),
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
