import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_option_tile.dart';

class GenderScreen extends StatefulWidget {
  final String userName;
  const GenderScreen({super.key, required this.userName});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selectedGender;
  String? _selectedExtendedGender;

  final List<String> _genders = ['Woman', 'Man', 'Nonbinary'];

  final Map<String, List<String>> _extendedOptions = {
    'Woman': [
      'Intersex woman',
      'Trans woman',
      'Transfeminine',
      'Woman and Nonbinary',
      'Cis woman',
    ],
    'Man': [
      'Intersex man',
      'Trans man',
      'Transmasculine',
      'Man and Nonbinary',
      'Cis man',
    ],
    'Nonbinary': [
      'Agender',
      'Bigender',
      'Genderfluid',
      'Genderqueer',
      'Gender non-conforming',
      'Pangender',
      'Queer',
      'Two-spirit',
    ],
  };

  void _showMissingGenderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Are we missing your gender?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please tell us your gender if it isn\'t included and we\'ll do our best to add it.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              cursorColor: Colors.black45,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Type your gender here',
                hintStyle: const TextStyle(color: Colors.black26, fontSize: 18),
                contentPadding: const EdgeInsets.only(bottom: 8),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1.5),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45, width: 2),
                ),
              ),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'NO THANKS',
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'SUBMIT',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExtendedGenderModal(String mainGender) {
    String? tempSelected = _selectedExtendedGender;
    final options = _extendedOptions[mainGender] ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded, size: 22, color: Colors.black54),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const Expanded(
                      child: Text(
                        'Add more about your gender',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'You can choose whether to show this on your profile at\nthe next step',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    controller: controller,
                    itemCount: options.length + 1,
                    separatorBuilder: (_, __) => Divider(color: Colors.black.withOpacity(0.05), height: 1),
                    itemBuilder: (context, index) {
                      if (index == options.length) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Tell us if we\'re missing something',
                            style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black26),
                          onTap: _showMissingGenderDialog,
                        );
                      }
                      final opt = options[index];
                      final isSel = tempSelected == opt;
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          opt,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                        trailing: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSel ? Colors.black87 : Colors.black12,
                              width: 1.5,
                            ),
                            color: Colors.white,
                          ),
                          child: isSel
                              ? Center(
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFFD700),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        onTap: () => setModalState(() => tempSelected = opt),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _selectedExtendedGender = tempSelected);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF333333),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save and close',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const OnboardingProgressBar(value: 0.30),
                        const SizedBox(height: 32),
                        Text(
                          '${widget.userName} is a great name',
                          style: AppTextStyles.displayMedium.copyWith(
                            color: Colors.black87,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We love that you\'re here. Pick the gender that\nbest describes you, then add more about it if\nyou like.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.black54,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Which gender best describes you?',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Gender Options
                        ..._genders.map((gender) => _buildGenderOption(gender)),
                        
                        const SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline_rounded, size: 20, color: Colors.black38),
                            const SizedBox(width: 12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.black38,
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                  children: [
                                    const TextSpan(text: 'You can always update this later. '),
                                    TextSpan(
                                      text: 'A note about gender on LoveAxis.',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
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
                              enabled: _selectedGender != null,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.genderVisibility,
                                  arguments: _selectedExtendedGender ?? _selectedGender,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    bool isSelected = _selectedGender == gender;
    return Column(
      children: [
        OnboardingOptionTile(
          title: gender,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedGender = gender;
              _selectedExtendedGender = null;
            });
          },
        ),
        if (isSelected) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => _showExtendedGenderModal(gender),
              child: Row(
                children: [
                  Text(
                    _selectedExtendedGender ?? 'Add more about your gender',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.black54),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
      ],
    );
  }
}
