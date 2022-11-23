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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return await Future.value();
        },
        child: BlocBuilder<StoriesListCubit, StoriesListState>(
          builder: (context, state) {
            if (state is StoriesListLoaded) {
              if (state.stories.isEmpty) {
                return Center(
                    child: Text("Сделайте первую запись!",
                        style: TextStyle(fontSize: 30)));
              } else {
                return ListView.builder(
                  itemCount: state.stories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(

                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border:
                                    Border.all(width: 4, color: Colors.green)),
                            height: 70,
                            child: Column(
                              children: [
                                Align(
                                    child: Text(
                                      state.stories[index].title,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    alignment: Alignment.centerLeft),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(state.stories[index].text),
                                )
                              ],
                            ),
                        ),
                        SizedBox(height: 8,)
                      ],
                    );
                  },
                );
              }
            } else if (state is StoriesListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StoriesListError) {
              return Center(child: Text(state.message));
            } else if (state is StoriesListEmpty) {
              return const Center(child: Text("InitState"));
            } else {
              return Text("Something goes wrong");
            }
          },
        ),
      ),
    );
  }
}
