import 'package:diary_app_final/features/authentication/presentation/bloc/cubit_auth/auth_cubit.dart';
import 'package:diary_app_final/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_story/story_bloc.dart';
import 'package:diary_app_final/features/story/presentation/pages/home_page.dart';
import 'package:diary_app_final/features/story/presentation/pages/story_list_page.dart';
import 'package:diary_app_final/features/story/presentation/pages/story_read_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'features/authentication/presentation/bloc/cubit_auth/auth_state.dart';
import 'features/story/presentation/bloc/cubit_story_list/stories_list_cubit.dart';
import 'features/authentication/presentation/pages/sign_up_page.dart';
import 'locator_service.dart' as di;
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print(value.options.projectId));
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoryBloc>(
            create: (context) => sl<StoryBloc>()),
        BlocProvider(
            create:(context) => sl<BlocAuthBloc>()),
        BlocProvider<AuthCubit>(
            create: (context) => sl<AuthCubit>()..launch()),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case       "/"       : return MaterialPageRoute(builder: (context) => const MyHomePage());
            case "/story_write_page" : return MaterialPageRoute(builder: (context) => StoryWritePage());
            case "/sign_in_page" : return MaterialPageRoute(builder: (context) => const SignInPage());
            case "/sign_up_page" : return MaterialPageRoute(builder: (context) => SignUpPage());
            case "/story_read_page" :
              final story = settings.arguments as StoryEntity;
              return MaterialPageRoute(builder: (context) => StoryReadPage(story: story));
          }
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LaunchingAuthState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SignedAuthState) {
              return const MyHomePage();
            } else if (state is NoSignedAuthState) {
              return const SignInPage();
            } else {
              return const Center(child: Text("Ошибка"));
            }
          },
        ),
      ),
    );
  }
}