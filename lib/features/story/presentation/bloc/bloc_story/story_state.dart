import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

abstract class StoryState {

}
class StoryInitState extends StoryState {}

class StoryUploadingState extends StoryState {
  // final StoryEntity story;
  // AddStoryUploadingState({required this.story});

}
class StoryUploadedState  extends StoryState {}

class StoryErrorState  extends StoryState {
  final String message;
  StoryErrorState({required this.message});
}