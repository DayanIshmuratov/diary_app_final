import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

abstract class AddStoryEvent {}

class AddStoryAdding extends AddStoryEvent {
  final StoryEntity story;
  AddStoryAdding(this.story);
}