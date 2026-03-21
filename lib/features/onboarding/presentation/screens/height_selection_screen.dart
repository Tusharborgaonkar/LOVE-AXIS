import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';

class HeightSelectionScreen extends StatefulWidget {
  const HeightSelectionScreen({super.key});

  @override
  State<HeightSelectionScreen> createState() => _HeightSelectionScreenState();
}

class _HeightSelectionScreenState extends State<HeightSelectionScreen> {
  int _selectedHeightCm = 170;
  bool _isMetric = true;

  String _formatHeight(int cm) {
    if (_isMetric) return '$cm cm';
    final totalInches = (cm / 2.54).round();
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    return "$feet'$inches\"";
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
              const OnboardingProgressBar(value: 0.70),
              const SizedBox(height: 48),
              const Text(
                "Now let's talk about you",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your height",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    // Unit Toggle
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildUnitToggle('cm', _isMetric),
                          _buildUnitToggle('ft', !_isMetric),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Height Picker
                    SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          ListWheelScrollView.useDelegate(
                            itemExtent: 60,
                            perspective: 0.005,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                _selectedHeightCm = 120 + index;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                final cm = 120 + index;
                                final isSelected = cm == _selectedHeightCm;
                                return Center(
                                  child: Text(
                                    _formatHeight(cm),
                                    style: TextStyle(
                                      fontSize: isSelected ? 32 : 24,
                                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                                      color: isSelected ? Colors.black87 : Colors.black26,
                                    ),
                                  ),
                                );
                              },
                              childCount: 101, // 120 to 220
                            ),
                            controller: FixedExtentScrollController(initialItem: 50), // 170cm
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OnboardingNextButton(
                    enabled: true,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.interests);
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

  Widget _buildUnitToggle(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _isMetric = label == 'cm'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black87 : Colors.black38,
          ),
        ),
      ),
    );
  }
}
