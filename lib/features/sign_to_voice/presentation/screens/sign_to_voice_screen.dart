import 'package:flutter/material.dart';

class SignToVoiceScreen extends StatelessWidget {
  const SignToVoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign to Voice'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More options',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.videocam, color: Colors.white, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'Camera feed will appear here',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Semantics(
                button: true,
                label: 'Start recording',
                container: true,
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.red, width: 4),
                  ),
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('Tap to start recording'),
            ],
          ),
          const SizedBox(height: 24),
          _buildTranscriptCard(),
          const SizedBox(height: 24),
          _buildQuickSettings(),
        ],
      ),
    );
  }

  Widget _buildTranscriptCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Live Transcript',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  tooltip: 'Copy transcript',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Your transcript will appear here as you sign...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play Audio'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.download),
                  tooltip: 'Download transcript',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSettingsTile(
          icon: Icons.translate,
          title: 'Language',
          subtitle: 'English (US)',
        ),
        const SizedBox(height: 8),
        _buildSettingsTile(
          icon: Icons.volume_up,
          title: 'Voice Speed',
          subtitle: 'Normal',
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
