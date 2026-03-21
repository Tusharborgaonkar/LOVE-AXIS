import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';

class GenderVisibilityScreen extends StatefulWidget {
  final String gender;

  const GenderVisibilityScreen({super.key, required this.gender});

  @override
  State<GenderVisibilityScreen> createState() => _GenderVisibilityScreenState();
}

class _GenderVisibilityScreenState extends State<GenderVisibilityScreen> {
  bool _showOnProfile = false;

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
              const OnboardingProgressBar(value: 0.35),
              const SizedBox(height: 48),
              const Text(
                'Want to show your gender\non your profile?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'It\'s totally up to you whether you feel\ncomfortable sharing this.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Shown as:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.gender,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Show on profile',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch(
                    value: _showOnProfile,
                    onChanged: (val) => setState(() => _showOnProfile = val),
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black87,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.black12,
                    trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
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
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.email);
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
