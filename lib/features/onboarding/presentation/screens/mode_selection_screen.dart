import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class ModeSelectionScreen extends StatefulWidget {
  const ModeSelectionScreen({super.key});

  @override
  State<ModeSelectionScreen> createState() => _ModeSelectionScreenState();
}

class _ModeSelectionScreenState extends State<ModeSelectionScreen> {
  String? _selectedMode = 'date'; // Default selection as per screenshot

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
              const OnboardingProgressBar(value: 0.45),
              const SizedBox(height: 48),
              const Text(
                'What brings you to\nBumble?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Romance and butterflies or a beautiful\nfriendship? Choose a mode to find your\npeople.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
              OnboardingOptionTile(
                title: 'Date',
                subtitle: 'Find a relationship, something casual, or anything in-between',
                isSelected: _selectedMode == 'date',
                onTap: () => setState(() => _selectedMode = 'date'),
              ),
              const SizedBox(height: 16),
              OnboardingOptionTile(
                title: 'BFF',
                subtitle: 'Make new friends and find your community',
                isSelected: _selectedMode == 'bff',
                onTap: () => setState(() => _selectedMode = 'bff'),
              ),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.visibility_outlined, size: 22, color: Colors.black45),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'You\'ll only be shown to people in the same mode as you.',
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
              const Spacer(),
              // Next Button
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OnboardingNextButton(
                    enabled: _selectedMode != null,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.meetingPreference);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
