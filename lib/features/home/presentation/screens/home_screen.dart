import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';
import 'package:s2s_app/features/voice_to_avatar/presentation/screens/voice_to_avatar_screen.dart';
import 'package:s2s_app/features/video_to_avatar/presentation/screens/video_to_avatar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildWelcomeMessage(),
                  const SizedBox(height: 24),
                  _buildFeatureCard(
                    context,
                    icon: Icons.sign_language,
                    title: 'sign_language_to_voice'.tr(),
                    subtitle: 'sign_language_to_voice_desc'.tr(),
                    color: Theme.of(context).colorScheme.primary,
                    isPrimary: true,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SignToVoiceScreen())),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureCard(
                    context,
                    icon: Icons.mic,
                    title: 'voice_to_avatar'.tr(),
                    subtitle: 'voice_to_avatar_desc'.tr(),
                    color: Colors.grey.shade200,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const VoiceToAvatarScreen())),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureCard(
                    context,
                    icon: Icons.videocam,
                    title: 'video_to_avatar'.tr(),
                    subtitle: 'video_to_avatar_desc'.tr(),
                    color: Colors.grey.shade200,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const VideoToAvatarScreen())),
                  ),
                  const SizedBox(height: 24),
                  _buildQuickAccess(),
                  const SizedBox(height: 24),
                  _buildRecentActivity(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.waving_hand, color: Colors.white),
              ),
              const SizedBox(width: 8),
              const Text(
                'SignVoice',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'notifications'.tr(),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'welcome_back'.tr(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'how_can_help'.tr(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required Color color,
      required VoidCallback onTap,
      bool isPrimary = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? color : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isPrimary ? Colors.white24 : color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: isPrimary
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isPrimary ? Colors.white : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isPrimary ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'quick_access'.tr(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.5,
          children: [
            _buildQuickAccessButton(icon: Icons.history, label: 'recent'.tr()),
            _buildQuickAccessButton(icon: Icons.bookmark, label: 'saved'.tr()),
            _buildQuickAccessButton(icon: Icons.translate, label: 'languages'.tr()),
            _buildQuickAccessButton(icon: Icons.headset_mic, label: 'help'.tr()),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessButton(
      {required IconData icon, required String label}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'recent_activity'.tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('view_all'.tr()),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActivityItem(
            context: context,
            icon: Icons.waving_hand,
            title: 'sign_to_voice_session'.tr(),
            subtitle: 'hours_ago'.tr(namedArgs: {'hours': '2'}) + ' • ' + 'min_duration'.tr(namedArgs: {'minutes': '5'})),
        _buildActivityItem(
            context: context,
            icon: Icons.mic,
            title: 'voice_to_avatar_session'.tr(),
            subtitle: 'yesterday'.tr() + ' • ' + 'min_duration'.tr(namedArgs: {'minutes': '3'})),
        _buildActivityItem(
            context: context,
            icon: Icons.videocam,
            title: 'video_conversion'.tr(),
            subtitle: 'days_ago'.tr(namedArgs: {'days': '2'}) + ' • ' + 'min_duration'.tr(namedArgs: {'minutes': '8'})),
      ],
    );
  }

  Widget _buildActivityItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
