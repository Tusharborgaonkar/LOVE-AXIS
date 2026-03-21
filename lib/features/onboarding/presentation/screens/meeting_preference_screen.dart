import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class MeetingPreferenceScreen extends StatefulWidget {
  const MeetingPreferenceScreen({super.key});

  @override
  State<MeetingPreferenceScreen> createState() => _MeetingPreferenceScreenState();
}

class _MeetingPreferenceScreenState extends State<MeetingPreferenceScreen> {
  bool _isOpenToEveryone = false;
  final List<String> _selectedOptions = [];

  void _toggleOption(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
      _isOpenToEveryone = _selectedOptions.length == 3;
    });
  }

  void _toggleOpenToEveryone(bool value) {
    setState(() {
      _isOpenToEveryone = value;
      if (value) {
        _selectedOptions.clear();
        _selectedOptions.addAll(['Men', 'Women', 'Nonbinary people']);
      } else {
        _selectedOptions.clear();
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
              const OnboardingProgressBar(value: 0.50),
              const SizedBox(height: 48),
              const Text(
                'Who would you like to\nmeet?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'You can choose more than one answer and\nchange it any time.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'I\'m open to dating everyone',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: _isOpenToEveryone,
                    onChanged: _toggleOpenToEveryone,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black87,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.black12,
                    trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildMeetingOption('Men'),
              const SizedBox(height: 12),
              _buildMeetingOption('Women'),
              const SizedBox(height: 12),
              _buildMeetingOption('Nonbinary people'),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.visibility_outlined, size: 22, color: Colors.black45),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'You\'ll only be shown to people looking to date your gender.',
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
                    enabled: _selectedOptions.isNotEmpty,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.datingIntent);
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

  Widget _buildMeetingOption(String option) {
    final isSelected = _selectedOptions.contains(option);
    return OnboardingOptionTile(
      title: option,
      isSelected: isSelected,
      onTap: () => _toggleOption(option),
    );
  }
}
