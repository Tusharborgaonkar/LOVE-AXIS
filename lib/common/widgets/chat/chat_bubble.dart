import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMine;
  final String? timeText;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMine,
    this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: isMine
                  ? const LinearGradient(
                      colors: [Color(0xFFFF6B8A), Color(0xFFFF8FA3)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: isMine ? null : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isMine ? 18 : 4),
                bottomRight: Radius.circular(isMine ? 4 : 18),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isMine ? Colors.white : AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
          if (timeText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(timeText!, style: AppTextStyles.caption),
            ),
        ],
      ),
    );
  }
}

class MessageInputBar extends StatefulWidget {
  final ValueChanged<String>? onSend;

  const MessageInputBar({super.key, this.onSend});

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSend?.call(_controller.text.trim());
      _controller.clear();
      setState(() => _hasText = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add_rounded, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (v) => setState(() => _hasText = v.trim().isNotEmpty),
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: AppTextStyles.bodyMedium,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.emoji_emotions_outlined, color: AppColors.textHint, size: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: _hasText
                    ? const LinearGradient(colors: [Color(0xFFFF6B8A), Color(0xFFC9B8FF)])
                    : const LinearGradient(colors: [Color(0xFFEEDDEE), Color(0xFFEEDDEE)]),
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: _send,
                child: Icon(
                  _hasText ? Icons.send_rounded : Icons.mic_rounded,
                  color: _hasText ? Colors.white : AppColors.textHint,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
