import 'package:flutter/material.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class DatingIntentScreen extends StatefulWidget {
  const DatingIntentScreen({super.key});

  @override
  State<DatingIntentScreen> createState() => _DatingIntentScreenState();
}

class _DatingIntentScreenState extends State<DatingIntentScreen> {
  final List<String> _selectedIntents = [];
  final List<String> _intents = [
    'A long-term relationship',
    'A life partner',
    'Fun, casual dates',
    'Intimacy, without commitment',
    'Marriage',
    'Ethical non-monogamy',
  ];

  void _toggleIntent(String intent) {
    setState(() {
      if (_selectedIntents.contains(intent)) {
        _selectedIntents.remove(intent);
      } else if (_selectedIntents.length < 2) {
        _selectedIntents.add(intent);
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
              const OnboardingProgressBar(value: 0.60),
              const SizedBox(height: 48),
              const Text(
                'And what are you hoping\nto find?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'It\'s your dating journey, so choose 1 or 2\noptions that feel right for you.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: _intents.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => _buildIntentOption(_intents[index]),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.visibility_outlined, size: 22, color: Colors.black45),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'This will show on your profile to help everyone find what they\'re looking for.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_selectedIntents.length}/2 selected',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    OnboardingNextButton(
                      enabled: _selectedIntents.isNotEmpty,
                      onTap: () {
                        // TODO: Navigate to next step
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

  Widget _buildIntentOption(String intent) {
    final isSelected = _selectedIntents.contains(intent);
    return OnboardingOptionTile(
      title: intent,
      isSelected: isSelected,
      onTap: () => _toggleIntent(intent),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Colors.black87 : Colors.black12,
            width: 1.5,
          ),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: isSelected
            ? const Center(
                child: Icon(Icons.check, size: 16, color: Colors.black87),
              )
            : null,
      ),
    );
  }
}
