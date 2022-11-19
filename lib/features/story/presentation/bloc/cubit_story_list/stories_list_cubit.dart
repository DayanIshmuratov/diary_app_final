import 'package:diary_app_final/common/error_messages.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/story/presentation/bloc/cubit_story_list/stories_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_all_stories/get_all_stories.dart';



class StoriesListCubit extends Cubit<StoriesListState> {
  final String userId;
  final GetAllStories getAllStories;
  StoriesListCubit({required this.getAllStories, required this.userId}) : super(StoriesListEmpty());
  loadStories() async {
    emit(StoriesListLoading());
    final failureOrStory = await getAllStories(userId);
    failureOrStory.fold(
            (error) => emit(StoriesListError(message: _mapFailureToMessage(error))),
            (stories) => emit(StoriesListLoaded(stories: stories)));
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure :
      return ErrorMessages.ServerFailureMessage;
    default : return 'Unexpected error';
  }

}