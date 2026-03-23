class StoryModel {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final String storyImage;
  final List<String>? storyImages;
  final bool isSeen;

  const StoryModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.storyImage,
    this.storyImages,
    this.isSeen = false,
  });
}
