import 'package:diary_app_final/core/validators/validator.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_story/story_bloc.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_story/story_event.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_story/story_state.dart';
import 'package:diary_app_final/features/story/presentation/bloc/cubit_story_list/stories_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/story_entity.dart';

class StoryWrite extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<StoryBloc>();
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.book),
                    hintText: "Название",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    )
                ),
                controller: _titleController,
                validator: (value) {
                  return Validator.validateTitle(title: value as String);
                }
            ),
            SizedBox(height: 8),
            Expanded(
              child: TextFormField(
                  maxLines: 45,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.history_edu),
                      hintText: "Содержимое",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                  controller: _textController,
                  validator: (value) {
                    return Validator.validateText(text: value as String);
                  }
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  final StoryEntity story = StoryEntity(
                      title: _titleController.text, text: _textController.text, date: null);
                  _bloc.add(AddStoryEvent(story));
                  Navigator.pop(context);
                }
              },
              child: Text("Сохранить"),
            ),
          ],
        ),
      ),
    );
  }
}