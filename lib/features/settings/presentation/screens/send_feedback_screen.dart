import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({super.key});

  @override
  State<SendFeedbackScreen> createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  int _selectedRating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    // Simulate feedback submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Thank you for your feedback!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.primary,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Send Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(child: Text('How was your experience?', style: AppTextStyles.headlineSmall)),
            const SizedBox(height: 24),
            _buildEmojiPicker(),
            const SizedBox(height: 40),
            Text('Tell us more about it', style: AppTextStyles.titleMedium),
            const SizedBox(height: 12),
            _buildFeedbackField(),
            const SizedBox(height: 48),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiPicker() {
    final emojis = ['😠', '☹️', '😐', '🙂', '🤩'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(emojis.length, (index) {
        final isSelected = _selectedRating == index + 1;
        return GestureDetector(
          onTap: () => setState(() => _selectedRating = index + 1),
          child: Column(
            children: [
              AnimatedScale(
                scale: isSelected ? 1.4 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Text(emojis[index], style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(height: 8),
              if (isSelected)
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFeedbackField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.05), blurRadius: 10)],
      ),
      child: TextField(
        controller: _feedbackController,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: 'Share your thoughts, suggestions, or report an issue...',
          contentPadding: const EdgeInsets.all(16),
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _selectedRating > 0 ? _submitFeedback : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Submit Feedback', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
