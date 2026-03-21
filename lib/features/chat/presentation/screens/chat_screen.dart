import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/chat_model.dart';
import '../../../../data/dummy/dummy_chats.dart';
import '../../../../common/widgets/common/app_network_image.dart';
import '../../../../common/widgets/chat/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messages = List.from(dummyMessages);
  final _controller = TextEditingController();
  bool _hasText = false;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(MessageModel(
        id: 'new_${DateTime.now().millisecondsSinceEpoch}',
        chatId: widget.chat.id,
        senderId: 'me',
        text: _controller.text.trim(),
        timestamp: DateTime.now(),
      ));
      _controller.clear();
      _hasText = false;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            ClipOval(child: AppNetworkImage(url: widget.chat.userImage, width: 38, height: 38)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chat.userName, style: AppTextStyles.titleMedium),
                Text(
                  widget.chat.isOnline ? '● Online' : 'Last seen recently',
                  style: AppTextStyles.caption.copyWith(
                    color: widget.chat.isOnline ? AppColors.online : AppColors.textHint,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: AppColors.textSecondary),
            onPressed: () => _showTopSnackBar('Starting video call... 🎥'),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.textSecondary),
            onSelected: (v) => _showTopSnackBar('$v selected'),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'View Profile', child: Text('View Profile')),
              const PopupMenuItem(value: 'Mute Notifications', child: Text('Mute Notifications')),
              const PopupMenuItem(value: 'Clear Chat', child: Text('Clear Chat')),
              const PopupMenuItem(value: 'Block', child: Text('Block', style: TextStyle(color: Colors.red))),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                final isMine = msg.senderId == 'me';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: ChatBubble(
                    text: msg.text,
                    isMine: isMine,
                    timeText: _formatTime(msg.timestamp),
                  ),
                );
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: AppColors.shadow.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: _showMediaSheet,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.add_rounded, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 46,
                decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(23)),
                child: TextField(
                  controller: _controller,
                  onChanged: (v) => setState(() => _hasText = v.trim().isNotEmpty),
                  style: AppTextStyles.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: AppTextStyles.bodyMedium,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    suffixIcon: InkWell(
                      onTap: () => _showTopSnackBar('Emoji picker coming soon! 😊'),
                      borderRadius: BorderRadius.circular(20),
                      child: const Icon(Icons.emoji_emotions_outlined, color: AppColors.textHint, size: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: _hasText ? _send : () => _showTopSnackBar('Recording voice message... 🎙️'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: _hasText ? AppGradients.primary : const LinearGradient(colors: [Color(0xFFEEDDEE), Color(0xFFEEDDEE)]),
                  shape: BoxShape.circle,
                ),
                child: Icon(_hasText ? Icons.send_rounded : Icons.mic_rounded,
                    color: _hasText ? Colors.white : AppColors.textHint, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTopSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showMediaSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _mediaItem(Icons.image_rounded, 'Gallery', Colors.blue),
                  _mediaItem(Icons.camera_alt_rounded, 'Camera', Colors.pink),
                  _mediaItem(Icons.location_on_rounded, 'Location', Colors.green),
                  _mediaItem(Icons.person_rounded, 'Contact', Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mediaItem(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        _showTopSnackBar('$label feature coming soon!');
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
