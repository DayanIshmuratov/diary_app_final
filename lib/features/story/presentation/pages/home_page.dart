import 'package:diary_app_final/common/app_colors.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_event.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_add_story/add_story_bloc.dart';
import 'package:diary_app_final/features/story/presentation/bloc/cubit_story_list/stories_list_cubit.dart';
import 'package:diary_app_final/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/story_write.dart';
import '../widgets/story_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
      final _blocAuth = context.read<BlocAuthBloc>();
      return MultiBlocProvider(
        providers: [
          BlocProvider<StoriesListCubit>(
              create: (context) => sl<StoriesListCubit>()),
        ],
        child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                  await Navigator.pushNamed(context, "/story_page");
                  setState(() {});
              },
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text("Diary App"),
              actions: [
               IconButton(onPressed: () {
                 _blocAuth.add(BlocAuthLogOutEvent());
               },
               icon: Icon(Icons.logout),
               ),
              ],
            ),
            body: StoryList()
        ),
      );
    }
}