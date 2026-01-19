import 'package:flutter/material.dart';

class VideoToAvatarScreen extends StatelessWidget {
  const VideoToAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video to Avatar'),
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
          const Text(
            'Upload a video of yourself signing, and our AI will generate a dynamic avatar replicating your gestures.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          _buildUploadCard(),
          const SizedBox(height: 16),
          _buildProgressCard(),
          const SizedBox(height: 16),
          _buildAvatarPreview(),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Generate Avatar'),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.blue, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.cloud_upload,
                  color: Colors.blue, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload Video',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'MP4, MOV or AVI (Max 50MB)',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Select File'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.play_circle, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('signing_demo_v1.mp4'),
                      Text('85%', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Semantics(
                    label: 'Upload progress: 85%',
                    child: LinearProgressIndicator(
                      value: 0.85,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Analyzing hand gestures...',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Cancel upload',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPreview() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCn0AhHUGwd02cNsQJ7lxSv9ev8qCfluiccRPC-WtVZ6YD_SJ49Qofncj2zYprakwn5mRWT8iWxGePwkmJnxjA37TraUkJURBwyrZiwKKfXHLW-ZikCe3kizbMZjAchwXdFik3HkX54JaD0e72v-rKnx2WVhHsqYdRe4FViR2V_n-FA8mgufgffP0d2fMFH2JVPcQvRLjatkfmtjRMK6uaSCtsUSaQPmtASrR3HaZW4EA7Btm27gHFUBHYsUwqWBsXPmL9mRQqvBIw'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your avatar will mirror the signs detected in the video. Use controls below to refine.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.accessibility_new),
                  label: const Text('Posture'),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.face),
                  label: const Text('Expression'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
