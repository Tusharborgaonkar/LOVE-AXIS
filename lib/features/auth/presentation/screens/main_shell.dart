import 'package:flutter/material.dart';
import '../../../../common/widgets/navigation/custom_bottom_navbar.dart';
import '../../../discover/presentation/screens/discover_screen.dart';
import '../../../matches/presentation/screens/matches_screen.dart';
import '../../../chat/presentation/screens/chat_list_screen.dart';
import '../../../profile/presentation/screens/my_profile_screen.dart';
import '../../presentation/screens/likes_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _screens = const [
    DiscoverScreen(),
    LikesScreen(),
    MatchesScreen(),
    ChatListScreen(),
    MyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F9),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
