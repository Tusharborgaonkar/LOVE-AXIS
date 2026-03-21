import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/onboarding/presentation/screens/phone_number_screen.dart';
import '../../features/onboarding/presentation/screens/otp_verification_screen.dart';
import '../../features/onboarding/presentation/screens/intro_screen.dart';
import '../../features/onboarding/presentation/screens/gender_screen.dart';
import '../../features/onboarding/presentation/screens/gender_visibility_screen.dart';
import '../../features/onboarding/presentation/screens/email_screen.dart';
import '../../features/onboarding/presentation/screens/mode_selection_screen.dart';
import '../../features/onboarding/presentation/screens/meeting_preference_screen.dart';
import '../../features/onboarding/presentation/screens/dating_intent_screen.dart';
import '../../features/auth/presentation/screens/main_shell.dart';
import '../../features/auth/presentation/screens/likes_screen.dart';
import '../../features/profile/presentation/screens/profile_detail_screen.dart';
import '../../features/profile/presentation/screens/my_profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/settings/presentation/screens/notifications_screen.dart';
import '../../features/settings/presentation/screens/premium_screen.dart';
import '../../features/discover/presentation/screens/story_view_screen.dart';
import '../../data/models/profile_model.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/story_model.dart';
import '../../data/dummy/dummy_chats.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _fade(const SplashScreen());

      case RouteNames.welcome:
        return _fade(const WelcomeScreen());
      case RouteNames.onboarding:
        return _slide(const OnboardingScreen());

      case RouteNames.login:
        return _slide(const LoginScreen());

      case RouteNames.signup:
        return _slide(const SignupScreen());
      case RouteNames.phoneNumber:
        return _slide(const PhoneNumberScreen());
      case RouteNames.otpVerification:
        final phoneNumber = settings.arguments as String? ?? '';
        return _slide(OtpVerificationScreen(phoneNumber: phoneNumber));
      case RouteNames.intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case RouteNames.gender:
        final name = settings.arguments as String? ?? 'User';
        return MaterialPageRoute(
          builder: (_) => GenderScreen(userName: name),
        );
      case RouteNames.genderVisibility:
        final gender = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => GenderVisibilityScreen(gender: gender));
      case RouteNames.email:
        return MaterialPageRoute(builder: (_) => const EmailScreen());
      case RouteNames.modeSelection:
        return MaterialPageRoute(builder: (_) => const ModeSelectionScreen());
      case RouteNames.meetingPreference:
        return MaterialPageRoute(builder: (_) => const MeetingPreferenceScreen());
      case RouteNames.datingIntent:
        return MaterialPageRoute(builder: (_) => const DatingIntentScreen());
      case RouteNames.main:
        return _fade(const MainShell());

      case RouteNames.likes:
        return _slide(const LikesScreen());

      case RouteNames.profileDetail:
        final profile = settings.arguments as ProfileModel?;
        if (profile == null) return _error(settings.name);
        return _slide(ProfileDetailScreen(profile: profile));

      case RouteNames.chatDetail:
        final chat = settings.arguments as ChatModel? ?? dummyChats[0];
        return _slide(ChatScreen(chat: chat));

      case RouteNames.editProfile:
        return _slide(const EditProfileScreen());

      case RouteNames.premium:
        return _slideUp(const PremiumScreen());

      case RouteNames.notifications:
        return _slide(const NotificationsScreen());

      case RouteNames.settings:
        return _slide(const SettingsScreen());

      case RouteNames.storyView:
        final story = settings.arguments as StoryModel?;
        if (story == null) return _error(settings.name);
        return _fade(StoryViewScreen(story: story));

      default:
        return _error(settings.name);
    }
  }

  static Route<dynamic> _fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<dynamic> _slide(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  static Route<dynamic> _slideUp(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  static Route<dynamic> _error(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for $name')),
      ),
    );
  }
}
