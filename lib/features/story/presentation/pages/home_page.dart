import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/bloc_auth/bloc_auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/story_write.dart';
import '../widgets/story_list_widget.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    final _blocAuth = context.read<BlocAuthBloc>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/story_page");
          },
      ),
      appBar: AppBar(
        title: Text("Hello world"),
        actions: [
          GestureDetector(
              onTap: () {
                _blocAuth.add(BlocAuthLogOutEvent());
              },
              child: Text("Выйти из аккаунта")
          ),
        ],
      ),
      body: StoryList()
    );
  }
}