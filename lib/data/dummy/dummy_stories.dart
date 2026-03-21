import '../models/story_model.dart';

final List<StoryModel> dummyStories = [
  StoryModel(
    id: 's1',
    userId: 'p1',
    userName: 'Sophia',
    userImage: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200',
    storyImage: 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800',
    isSeen: false,
  ),
  StoryModel(
    id: 's2',
    userId: 'p2',
    userName: 'Aria',
    userImage: 'https://images.unsplash.com/photo-1488716820095-cbe80883c496?w=200',
    storyImage: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
    isSeen: false,
  ),
  StoryModel(
    id: 's3',
    userId: 'p3',
    userName: 'Luna',
    userImage: 'https://images.unsplash.com/photo-1515023115689-589c33041d3c?w=200',
    storyImage: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800',
    isSeen: true,
  ),
  StoryModel(
    id: 's4',
    userId: 'p4',
    userName: 'Maya',
    userImage: 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=200',
    storyImage: 'https://images.unsplash.com/photo-1518173946687-a4c8892bbd9f?w=800',
    isSeen: true,
  ),
];
