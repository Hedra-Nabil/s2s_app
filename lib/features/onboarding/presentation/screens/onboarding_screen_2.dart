import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'skip'.tr(),
                    style: const TextStyle(color: Color(0xFF1E73BE)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'how_it_works'.tr(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'how_it_works_desc'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              _buildFeatureCard(
                icon: Icons.back_hand,
                title: 'sign_to_voice_feature'.tr(),
                subtitle: 'sign_to_voice_feature_desc'.tr(),
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                icon: Icons.record_voice_over,
                title: 'voice_to_avatar_feature'.tr(),
                subtitle: 'voice_to_avatar_feature_desc'.tr(),
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                icon: Icons.videocam,
                title: 'video_to_avatar_feature'.tr(),
                subtitle: 'video_to_avatar_feature_desc'.tr(),
              ),
              const Spacer(),
            ],
          ),
        ),
    );
  }

  Widget _buildFeatureCard(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: MergeSemantics(
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExcludeSemantics(
                child: Icon(icon, color: const Color(0xFF1E73BE)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
