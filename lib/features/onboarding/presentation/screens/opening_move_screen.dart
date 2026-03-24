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
  bool _isCustomSelected = false;
  late TextEditingController _customMoveController;
  late FocusNode _customMoveFocusNode;

  final List<String> _options = [
    "What’s your perfect weekend?",
    "Coffee or cocktails?",
    "What are you obsessed with right now?",
    "Your go-to comfort food?",
    "Dream travel destination?",
  ];

  @override
  void initState() {
    super.initState();
    _customMoveController = TextEditingController();
    _customMoveFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _customMoveController.dispose();
    _customMoveFocusNode.dispose();
    super.dispose();
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
                        title: _isCustomSelected ? null : "Write my own",
                        titleWidget: _isCustomSelected
                            ? TextField(
                                controller: _customMoveController,
                                focusNode: _customMoveFocusNode,
                                decoration: const InputDecoration(
                                  hintText: "Type your opening move...",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                                cursorColor: Colors.black87,
                                autofocus: true,
                                onChanged: (v) => setState(() {}),
                              )
                            : null,
                        isSelected: _isCustomSelected,
                        onTap: () {
                          setState(() {
                            _isCustomSelected = true;
                            _selectedMove = null;
                          });
                          _customMoveFocusNode.requestFocus();
                        },
                        trailing: _isCustomSelected
                            ? null
                            : const Icon(Icons.edit_note_rounded, color: Colors.black38),
                      );
                    }
                    final option = _options[index];
                    final isOptionSelected = !_isCustomSelected && _selectedMove == option;
                    return OnboardingOptionTile(
                      title: option,
                      isSelected: isOptionSelected,
                      onTap: () => setState(() {
                        _selectedMove = option;
                        _isCustomSelected = false;
                      }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OnboardingNextButton(
                    enabled: (_selectedMove != null && !_isCustomSelected) || (_isCustomSelected && _customMoveController.text.isNotEmpty),
                    onTap: () {
                      final move = _isCustomSelected ? _customMoveController.text : _selectedMove;
                      // You might want to pass 'move' to the next screen or save it.
                      // For now, I'll just navigate as before.
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
