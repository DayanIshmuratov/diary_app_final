import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app_final/common/error_messages.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/story/data/datasources/remote_user_info_source.dart';
import 'package:diary_app_final/features/story/domain/usecases/get_user_info/get_user_info.dart';
import 'package:diary_app_final/features/story/domain/usecases/update_story/update_story.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_story/add_story.dart';
import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final AddStory addStory;
  final UpdateStory updateStory;
  final GetUserInfo getUserInfo;
  final String userId;
  final FirebaseFirestore firestore;
  StoryBloc({required this.getUserInfo, required this.addStory, required this.userId, required this.updateStory, required this.firestore}) : super(StoryInitState()){
    on<AddStoryEvent>((event, emit) async {
        final failureOrUserInfo = await getUserInfo.getUserInfo(userId);
        failureOrUserInfo.fold(
                (failure) => emit(StoryErrorState(message: ErrorMessages.ServerFailureMessage)),
                (info) {
                  emit(StoryUploadingState());
                  addStory(userId, event.story, info.counterOfStory);
                  emit(StoryInitState());
                });
      }
    );

    on<UpdateStoryEvent>((event, emit) async {
      emit(StoryUploadingState());
      updateStory(userId, event.story);
      emit(StoryInitState());
    });
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