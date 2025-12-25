import 'package:flutter/material.dart';

class AvatarViewerScreen extends StatelessWidget {
  const AvatarViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar Viewer'),
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
          _buildExpressions(),
          const SizedBox(height: 24),
          _buildControls(),
          const SizedBox(height: 24),
          _buildPlaybackControls(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.videocam),
      ),
    );
  }

  Widget _buildAvatarDisplay() {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 150, color: Color(0xFF1D74D3)),
            SizedBox(height: 8),
            Chip(
              label: Text('Active'),
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpressions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Expressions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Reset'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildExpressionButton('😊', 'Happy', isSelected: true),
              _buildExpressionButton('😐', 'Neutral'),
              _buildExpressionButton('😮', 'Surprised'),
              _buildExpressionButton('👋', 'Wave'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpressionButton(String emoji, String label,
      {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[100] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSliderRow('Avatar Size', '100%'),
            _buildSliderRow('Posture Tilt', '0°'),
            _buildSliderRow('Animation Speed', '1.0x'),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value),
          ],
        ),
        Slider(
          value: 0.5,
          onChanged: (newValue) {},
        ),
      ],
    );
  }

  Widget _buildPlaybackControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.replay_10),
          label: const Text('Rewind'),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.forward_10),
          label: const Text('Skip'),
        ),
      ],
    );
  }
}
