import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app_final/common/error_messages.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/story/data/datasources/remote_user_info_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_story/add_story.dart';
import 'add_story_event.dart';
import 'add_story_state.dart';

class AddStoryBloc extends Bloc<AddStoryEvent, AddStoryState> {
  final AddStory addStory;
  final String userId;
  final RemoteUserInfoSource source;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AddStoryBloc({required this.addStory, required this.userId, required this.source}) : super(AddStoryInitState()){
    on<AddStoryAdding>((event, emit) async {
      // try {
        final info = await source.getUserInfo(userId);
        emit(AddStoryUploadingState());
        addStory(userId, event.story, info.counterOfStory);
        emit(AddStoryInitState());
      // }
      // on ServerFailure {
      //   emit(AddStoryErrorState(message: ErrorMessages.ServerFailureMessage));
      //   }
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