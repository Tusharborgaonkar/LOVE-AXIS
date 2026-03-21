import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';

class PersonalityPromptsScreen extends StatefulWidget {
  const PersonalityPromptsScreen({super.key});

  @override
  State<PersonalityPromptsScreen> createState() => _PersonalityPromptsScreenState();
}

class _PersonalityPromptsScreenState extends State<PersonalityPromptsScreen> {
  final List<Map<String, String>> _selectedPrompts = [];
  final List<String> _availablePrompts = [
    "My perfect weekend looks like...",
    "Two truths and a lie...",
    "I get excited about...",
    "Biggest green flag in a person...",
    "I’ll fall for you if...",
    "Tell me about your favorite travel memory",
    "What's your go-to karaoke song?",
    "If you could have dinner with anyone, who?"
  ];

  void _addPrompt(String prompt) {
    if (_selectedPrompts.length < 3) {
      setState(() {
        _selectedPrompts.add({'prompt': prompt, 'answer': ''});
      });
    }
  }

  void _editAnswer(int index, String answer) {
    setState(() {
      _selectedPrompts[index]['answer'] = answer;
    });
  }

  void _removePrompt(int index) {
    setState(() {
      _selectedPrompts.removeAt(index);
    });
  }

  bool get _isComplete => 
    _selectedPrompts.length == 3 && 
    _selectedPrompts.every((p) => p['answer']!.isNotEmpty);

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
              const OnboardingProgressBar(value: 0.95),
              const SizedBox(height: 48),
              const Text(
                "What makes you, you?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Select and answer 3 prompts (${_selectedPrompts.length}/3)",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: _selectedPrompts.length + (_selectedPrompts.length < 3 ? 1 : 0),
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    if (index == _selectedPrompts.length) {
                      return _buildAddButton();
                    }
                    return _buildPromptCard(index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: OnboardingNextButton(
                    enabled: _isComplete,
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.photoUpload);
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

  Widget _buildPromptCard(int index) {
    final item = _selectedPrompts[index];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFD700), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item['prompt']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _removePrompt(index),
                icon: const Icon(Icons.close, size: 20, color: Colors.black45),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            onChanged: (v) => _editAnswer(index, v),
            decoration: const InputDecoration(
              hintText: 'Type your answer...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black26),
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _showPromptSelection,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12, style: BorderStyle.none),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline_rounded, size: 32, color: Colors.black38),
              SizedBox(height: 8),
              Text(
                "Add a prompt",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPromptSelection() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select a prompt",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _availablePrompts.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final prompt = _availablePrompts[index];
                    final isUsed = _selectedPrompts.any((p) => p['prompt'] == prompt);
                    return ListTile(
                      title: Text(
                        prompt,
                        style: TextStyle(
                          color: isUsed ? Colors.black26 : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: isUsed ? null : () {
                        _addPrompt(prompt);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
