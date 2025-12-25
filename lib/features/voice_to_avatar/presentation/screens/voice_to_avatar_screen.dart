import 'package:flutter/material.dart';

class VoiceToAvatarScreen extends StatelessWidget {
  const VoiceToAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice to Avatar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildAvatarDisplay(),
          const SizedBox(height: 24),
          _buildRecordButton(),
          const SizedBox(height: 24),
          _buildCustomizeAvatar(),
          const SizedBox(height: 16),
          _buildRecentAvatars(),
        ],
      ),
    );
  }

  Widget _buildAvatarDisplay() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1D77D6),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 80),
          ),
          const SizedBox(height: 16),
          const Text('Your avatar will animate here'),
        ],
      ),
    );
  }

  Widget _buildRecordButton() {
    return Card(
      color: const Color(0xFF1D77D6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.mic, color: Color(0xFF1D77D6), size: 48),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap to record your voice',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Speak clearly for best results',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomizeAvatar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Avatar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Gender'),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Male'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      TextButton(onPressed: () {}, child: const Text('Female')),
                    ],
                  ),
                )
              ],
            ),
            const Divider(height: 32),
            _buildSettingsTile(
                icon: Icons.palette,
                title: 'Skin Tone',
                subtitle: 'Light',
                iconColor: Colors.orange),
            _buildSettingsTile(
                icon: Icons.checkroom,
                title: 'Clothing Style',
                subtitle: 'Casual',
                iconColor: Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAvatars() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.history, color: Colors.blue),
        ),
        title: const Text('Recent Avatars'),
        subtitle: const Text('View past animations'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  Widget _buildSettingsTile(
      {required IconData icon,
      required String title,
      required String subtitle,
      required Color iconColor}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
      contentPadding: EdgeInsets.zero,
    );
  }
}
