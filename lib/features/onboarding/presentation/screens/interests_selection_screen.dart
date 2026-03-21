import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';

class InterestsSelectionScreen extends StatefulWidget {
  const InterestsSelectionScreen({super.key});

  @override
  State<InterestsSelectionScreen> createState() => _InterestsSelectionScreenState();
}

class _InterestsSelectionScreenState extends State<InterestsSelectionScreen> {
  final List<String> _selectedInterests = [];
  final List<String> _interests = [
    '🎵 Music', '🎬 Movies', '🏋️ Gym', '✈️ Travel', '🍔 Food',
    '📚 Reading', '🎮 Gaming', '🐶 Pets', '🧘 Yoga', '📸 Photography',
    '🎨 Art', '🍳 Cooking', '🧗 Climbing', '🍷 Wine', '💃 Dancing',
    '☕ Coffee', '⚽ Sports', '🎤 Karaoke', '🌳 Nature', '♟️ Board Games'
  ];

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else if (_selectedInterests.length < 5) {
        _selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const OnboardingProgressBar(value: 0.75),
              const SizedBox(height: 48),
              const Text(
                "Choose up to 5 things you're really into",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _interests.map((interest) => _buildInterestChip(interest)).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_selectedInterests.length}/5 selected',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    OnboardingNextButton(
                      enabled: _selectedInterests.isNotEmpty,
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.habits);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInterestChip(String interest) {
    final isSelected = _selectedInterests.contains(interest);
    return GestureDetector(
      onTap: () => _toggleInterest(interest),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFD700) : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.black87 : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          interest,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.black87 : Colors.black54,
          ),
        ),
      ),
    );
  }
}
