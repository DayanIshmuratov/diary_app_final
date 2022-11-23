import 'package:diary_app_final/features/story/presentation/bloc/bloc_add_story/add_story_bloc.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_add_story/add_story_event.dart';
import 'package:diary_app_final/features/story/presentation/bloc/cubit_story_list/stories_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/story_entity.dart';
import '../bloc/bloc_add_story/add_story_state.dart';

class StoryWrite extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<AddStoryBloc>();
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
            ),
            SizedBox(height: 16),
            BlocBuilder<AddStoryBloc, AddStoryState> (
              builder: (context, state) {
                if (state is AddStoryInitState){
                  return ElevatedButton(
                    onPressed:() {
                      final StoryEntity story = StoryEntity(title: _titleController.text, text: "text", date: null);
                      _bloc.add(AddStoryAdding(story));
                      Navigator.pop(context);
                    },
                    child: Text("Сохранить"),
                  );
                } else if (state is AddStoryUploadingState) {
                  return const Center(child: CircularProgressIndicator(),);
                } else if (state is AddStoryErrorState) {
                  return Center(child: Text(state.message),);
                } else {
                  return Text("Неожиданная ошибка");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}