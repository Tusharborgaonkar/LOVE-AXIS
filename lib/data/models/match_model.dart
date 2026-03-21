import 'profile_model.dart';

class MatchModel {
  final String id;
  final ProfileModel profile;
  final DateTime matchedAt;
  final bool hasUnreadMessage;

  const MatchModel({
    required this.id,
    required this.profile,
    required this.matchedAt,
    this.hasUnreadMessage = false,
  });
}
