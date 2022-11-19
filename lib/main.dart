import 'package:diary_app_final/features/authentication/presentation/bloc/cubit_auth/auth_cubit.dart';
import 'package:diary_app_final/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_add_story/add_story_bloc.dart';
import 'package:diary_app_final/features/story/presentation/pages/home_page.dart';
import 'package:diary_app_final/features/story/presentation/pages/story_page.dart';
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
  // await FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     return print('Is not signed');
  //   } else {
  //     return print('Signed');
  //   }
  // });
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create:(context) => sl<BlocAuthBloc>()),
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit()..launch()),
        BlocProvider<StoriesListCubit>(
            create: (context) => sl<StoriesListCubit>()),
        BlocProvider<AddStoryBloc>(
            create: (context) => sl<AddStoryBloc>()),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case       "/"       : return MaterialPageRoute(builder: (context) => MyHomePage());
            case "/story_page"   : return MaterialPageRoute(builder: (context) => StoryPage());
            case "/sign_in_page" : return MaterialPageRoute(builder: (context) => SignInPage());
            case "/sign_up_page" : return MaterialPageRoute(builder: (context) => SignUpPage());
          }
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LaunchingAuthState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SignedAuthState) {
              return MyHomePage();
            } else if (state is NoSignedAuthState) {
              return SignInPage();
            } else {
              return Center(child: Text("Ошибка"));
            }
          },
        ),
      ),
    );
  }
}