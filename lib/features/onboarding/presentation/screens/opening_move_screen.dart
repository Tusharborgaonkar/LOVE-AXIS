import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class OpeningMoveScreen extends StatefulWidget {
  const OpeningMoveScreen({super.key});

  @override
  State<OpeningMoveScreen> createState() => _OpeningMoveScreenState();
}

class _OpeningMoveScreenState extends State<OpeningMoveScreen> {
  String? _selectedMove;
  final List<String> _options = [
    "What’s your perfect weekend?",
    "Coffee or cocktails?",
    "What are you obsessed with right now?",
    "Your go-to comfort food?",
    "Dream travel destination?",
  ];

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
              const OnboardingProgressBar(value: 0.96),
              const SizedBox(height: 48),
              const Text(
                "What’s your opening\nmove?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Pick a question your matches can answer first",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: _options.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == _options.length) {
                      return OnboardingOptionTile(
                        title: "Write my own",
                        isSelected: _selectedMove == "custom",
                        onTap: () => setState(() => _selectedMove = "custom"),
                        trailing: const Icon(Icons.edit_note_rounded, color: Colors.black38),
                      );
                    }
                    final option = _options[index];
                    return OnboardingOptionTile(
                      title: option,
                      isSelected: _selectedMove == option,
                      onTap: () => setState(() => _selectedMove = option),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OnboardingNextButton(
                    enabled: _selectedMove != null,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.firstMove);
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
