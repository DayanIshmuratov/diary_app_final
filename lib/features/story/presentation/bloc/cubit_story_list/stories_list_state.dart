

import '../../../domain/entities/story_entity.dart';

abstract class StoriesListState {}

class StoriesListEmpty extends StoriesListState {}
class StoriesListLoading extends StoriesListState {}
class StoriesListLoaded extends StoriesListState {
  List<StoryEntity> stories;
  StoriesListLoaded({required this.stories});
}
class StoriesListError extends StoriesListState {
  String message;
  StoriesListError({required this.message});
}