import '../models/match_model.dart';
import '../models/profile_model.dart';
import 'dummy_profiles.dart';

final List<MatchModel> dummyMatches = [
  MatchModel(
    id: 'match1',
    profile: dummyProfiles[0],
    matchedAt: DateTime.now().subtract(const Duration(hours: 1)),
    hasUnreadMessage: true,
  ),
  MatchModel(
    id: 'match2',
    profile: dummyProfiles[2],
    matchedAt: DateTime.now().subtract(const Duration(hours: 3)),
    hasUnreadMessage: false,
  ),
  MatchModel(
    id: 'match3',
    profile: dummyProfiles[1],
    matchedAt: DateTime.now().subtract(const Duration(days: 1)),
    hasUnreadMessage: false,
  ),
  MatchModel(
    id: 'match4',
    profile: dummyProfiles[4],
    matchedAt: DateTime.now().subtract(const Duration(days: 2)),
    hasUnreadMessage: true,
  ),
  MatchModel(
    id: 'match5',
    profile: dummyProfiles[3],
    matchedAt: DateTime.now().subtract(const Duration(days: 3)),
    hasUnreadMessage: false,
  ),
];

// Profiles that liked 'me'
final List<ProfileModel> dummyLikes = [
  dummyProfiles[0],
  dummyProfiles[2],
  dummyProfiles[4],
  dummyProfiles[1],
  dummyProfiles[3],
  dummyProfiles[5],
];
