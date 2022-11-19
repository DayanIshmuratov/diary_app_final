import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';
import 'package:diary_app_final/features/story/domain/repositories/repository.dart';

class AddStory {
  final StoryRepository storyRepository;
  AddStory({required this.storyRepository});
  void call(String userId, StoryEntity story) {
    return storyRepository.addStory(userId, story);
  }
}