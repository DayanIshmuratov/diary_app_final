import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

abstract class StoryEvent {}

class AddStoryEvent extends StoryEvent {
  final StoryEntity story;
  AddStoryEvent(this.story);
}

class UpdateStoryEvent extends StoryEvent{
  final StoryEntity story;
  UpdateStoryEvent(this.story);
}