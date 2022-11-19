import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

abstract class AddStoryState {

}
class AddStoryInitState extends AddStoryState {}

class AddStoryUploadingState extends AddStoryState {
  // final StoryEntity story;
  // AddStoryUploadingState({required this.story});

}
class AddStoryUploadedState  extends AddStoryState {}

class AddStoryErrorState     extends AddStoryState {
  final String message;
  AddStoryErrorState({required this.message});
}