import 'package:diary_app_final/common/error_messages.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_story/add_story.dart';
import 'add_story_event.dart';
import 'add_story_state.dart';

class AddStoryBloc extends Bloc<AddStoryEvent, AddStoryState> {
  final AddStory addStory;
  final String userId;
  AddStoryBloc({required this.addStory, required this.userId}) : super(AddStoryInitState()){
    on<AddStoryAdding>((event, emit) {
      try {
        emit(AddStoryUploadingState());
        addStory(userId, event.story);
        emit(AddStoryInitState());
      } on ServerFailure {
        emit(AddStoryErrorState(message: ErrorMessages.ServerFailureMessage));
        }
      }
    );
  }

  // on<AddStorySave>() {
  //   final story = 'f';
  //   emit(AddStoryUploadingState(story: story));
  //
  //   emit(AddStoryUploadedState());
  //
  //   emit(AddStoryErrorState(message: message));
  // }
}