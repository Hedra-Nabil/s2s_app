import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 24),
          _buildSettingsGroup('preferences'.tr(), [
            _buildSettingsTile(
              icon: Icons.translate,
              title: 'language'.tr(),
              subtitle: 'language_subtitle'.tr(),
              iconColor: Colors.blue,
            ),
            _buildSettingsTile(
              icon: Icons.graphic_eq,
              title: 'voice_avatar'.tr(),
              subtitle: 'voice_avatar_subtitle'.tr(),
              iconColor: Colors.purple,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSettingsGroup('app_settings'.tr(), [
            _buildToggleTile(
              icon: Icons.dark_mode,
              title: 'dark_mode'.tr(),
              iconColor: Colors.grey,
            ),
            _buildToggleTile(
              icon: Icons.notifications,
              title: 'notifications'.tr(),
              iconColor: Colors.orange,
              initialValue: true,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSettingsGroup('account'.tr(), [
            _buildSettingsTile(
              icon: Icons.lock,
              title: 'privacy_security'.tr(),
              iconColor: Colors.grey,
            ),
            _buildSettingsTile(
              icon: Icons.help,
              title: 'help_support'.tr(),
              iconColor: Colors.grey,
            ),
            _buildSettingsTile(
              icon: Icons.logout,
              title: 'log_out'.tr(),
              iconColor: Colors.red,
              textColor: Colors.red,
            ),
          ]),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'version'.tr(namedArgs: {'version': '2.4.0 (Build 392)'}),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBbQsM2LbEaNTPBUQm9tKmBRfWBldWQ2uuJtOOw3KNKTXhd80pPVqrcbjM9T4RN4Hyf8xb9ZZobbbT2hmO59gMd1ShskeaUoDLRI_ZR51xQka4dP5N4_GpVZdlmDGA0KgplECeJ2n_706xjZogrSOhkIhBWDQp-d7VcAtDb9cwihFycVmoHIrgBQX5n8Qc8LTXxjwLVD_8tgFmrDVF9pl1mxsh_x8mJ0UvbWveFhKYaKxafLz06n_6bwxDr5J-4t8odO7IsROYsUgY'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Sarah Jenkins',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'sarah.jenkins@example.com',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required Color iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing:
          textColor == null ? const Icon(Icons.chevron_right) : null,
      onTap: () {},
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required Color iconColor,
    bool initialValue = false,
  }) {
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      value: initialValue,
      onChanged: (bool value) {},
    );
  }
}
