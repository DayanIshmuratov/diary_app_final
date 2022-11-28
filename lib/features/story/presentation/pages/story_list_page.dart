import 'package:diary_app_final/features/story/presentation/bloc/bloc_story/story_bloc.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_story/story_state.dart';
import 'package:diary_app_final/features/story/presentation/widgets/story_write.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryWritePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adding story")),
      body: BlocBuilder<StoryBloc, StoryState>(
        builder: (context, state) {
          if (state is StoryInitState) {
            return StoryWrite();
          } else if (state is StoryUploadingState) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (state is StoryErrorState) {
            return Center(child: Text(state.message),);
          } else {
            return Text("Неожиданная ошибка");
          }
        },
      ),
    );
  }
}