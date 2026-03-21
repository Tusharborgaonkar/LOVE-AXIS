import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class FamilyKidsScreen extends StatefulWidget {
  const FamilyKidsScreen({super.key});

  @override
  State<FamilyKidsScreen> createState() => _FamilyKidsScreenState();
}

class _FamilyKidsScreenState extends State<FamilyKidsScreen> {
  int _currentStep = 1;
  String? _currentStatus;
  String? _futurePlans;

  final List<String> _statusOptions = ['No kids', 'Have kids', 'Prefer not to say'];
  final List<String> _planOptions = ['Want kids', 'Don’t want kids', 'Open to it'];

  void _onNext() {
    if (_currentStep == 1) {
      setState(() => _currentStep = 2);
    } else {
      Navigator.pushNamed(context, RouteNames.values);
    }
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
              const OnboardingProgressBar(value: 0.85),
              const SizedBox(height: 48),
              if (_currentStep == 1) ...[
                const Text(
                  "Do you have kids?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 32),
                ..._statusOptions.map((option) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: OnboardingOptionTile(
                    title: option,
                    isSelected: _currentStatus == option,
                    onTap: () => setState(() => _currentStatus = option),
                  ),
                )),
              ] else ...[
                const Text(
                  "What are your family plans?",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 32),
                ..._planOptions.map((option) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: OnboardingOptionTile(
                    title: option,
                    isSelected: _futurePlans == option,
                    onTap: () => setState(() => _futurePlans = option),
                  ),
                )),
              ],
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentStep == 2)
                      IconButton(
                        onPressed: () => setState(() => _currentStep = 1),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black38),
                      )
                    else
                      const SizedBox.shrink(),
                    OnboardingNextButton(
                      enabled: _currentStep == 1 ? _currentStatus != null : _futurePlans != null,
                      onTap: _onNext,
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
}
