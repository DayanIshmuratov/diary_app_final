import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit_story_list/stories_list_cubit.dart';
import '../bloc/cubit_story_list/stories_list_state.dart';
class StoryList extends StatefulWidget {
  const StoryList({Key? key}) : super(key: key);

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  @override
  Widget build(BuildContext context) {
    context.read<StoriesListCubit>().loadStories();
    return RefreshIndicator(
      onRefresh: () async {
        setState((){});
        return await Future.value();
      },
      child: BlocBuilder<StoriesListCubit, StoriesListState>(
        builder: (context, state) {
          if (state is StoriesListLoaded) {
            return ListView.builder(
              itemCount: state.stories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.stories[index].title),
                  subtitle: Text(state.stories[index].text),
                );
              },
            );
          } else if (state is StoriesListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StoriesListError){
            return Center(child: Text(state.message));
          }
          else if (state is StoriesListEmpty){
            return const Center(child: Text("InitState"));
          }
          else {
            return Text("Something goes wrong");
          }
        },
      ),
    );
  }
}

