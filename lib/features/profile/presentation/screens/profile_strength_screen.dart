import 'package:flutter/material.dart';

class ProfileStrengthScreen extends StatefulWidget {
  const ProfileStrengthScreen({super.key});

  @override
  State<ProfileStrengthScreen> createState() => _ProfileStrengthScreenState();
}

class _ProfileStrengthScreenState extends State<ProfileStrengthScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double _targetProgress = 0.22;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: _targetProgress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Text(
              '${(_animation.value * 100).toInt()}% complete',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Circular Progress
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return SizedBox(
                        width: 140,
                        height: 140,
                        child: CircularProgressIndicator(
                          value: _animation.value,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey.shade100,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.black87),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Text(
                        '${(_animation.value * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Start building your profile 🍃',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'It shouldn\'t take long and you\'ll be way more likely to match.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Grid of Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                   _buildStrengthCard(
                    icon: Icons.edit_note_rounded,
                    title: 'Bio',
                    status: 'Not written',
                    iconColor: Colors.amber.shade200,
                  ),
                  _buildStrengthCard(
                    icon: Icons.verified_user_rounded,
                    title: 'Get verified',
                    status: 'Not verified',
                    iconColor: Colors.blueAccent.shade100,
                  ),
                  _buildStrengthCard(
                    icon: Icons.badge_outlined,
                    title: 'Basic info',
                    status: '2 of 5 added',
                    iconColor: Colors.amber.shade100,
                  ),
                   _buildStrengthCard(
                    icon: Icons.explore_outlined,
                    title: 'More about you',
                    status: '2 of 9 added',
                    iconColor: Colors.amber.shade200,
                  ),
                   _buildStrengthCard(
                    icon: Icons.photo_library_outlined,
                    title: 'Photos',
                    status: '3 of 4 added',
                    iconColor: Colors.amber.shade100,
                  ),
                   _buildStrengthCard(
                    icon: Icons.mic_none_rounded,
                    title: 'Prompts',
                    status: '1 of 3 added', 
                    iconColor: Colors.amber.shade200,
                  ),
                  _buildStrengthCard(
                    icon: Icons.interests_outlined,
                    title: 'Interests',
                    status: '0 of 5 added',
                    iconColor: Colors.amber.shade100,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStrengthCard({
    required IconData icon,
    required String title,
    required String status,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: iconColor.withOpacity(0.8)),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
