class ProfileModel {
  final String id;
  final String name;
  final int age;
  final String location;
  final double distance;
  final String bio;
  final List<String> interests;
  final List<String> imageUrls;
  final bool isOnline;
  final bool isVerified;
  final int compatibilityScore;
  final String job;
  final String education;
  final String height;
  final String zodiac;
  final String lookingFor;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.distance,
    required this.bio,
    required this.interests,
    required this.imageUrls,
    this.isOnline = false,
    this.isVerified = false,
    this.compatibilityScore = 80,
    this.job = '',
    this.education = '',
    this.height = '',
    this.zodiac = '',
    this.lookingFor = 'Relationship',
  });

  String get displayName => '$name, $age';
  String get distanceText => '${distance.toStringAsFixed(1)} km away';
  String get primaryImage => imageUrls.isNotEmpty ? imageUrls[0] : '';
}
