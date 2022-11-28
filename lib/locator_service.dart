import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app_final/core/platform/network_info.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_log_out.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_sign_in.dart';
import 'package:diary_app_final/features/authentication/data/fire_auth/fire_auth_sign_up.dart';
import 'package:diary_app_final/features/authentication/data/repository/user_repository_impl.dart';
import 'package:diary_app_final/features/authentication/domain/repository/user_repository.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/log_out.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/sign_in.dart';
import 'package:diary_app_final/features/authentication/domain/usecases/sign_up.dart';
import 'package:diary_app_final/features/authentication/presentation/bloc/cubit_auth/auth_cubit.dart';
import 'package:diary_app_final/features/story/data/datadestinations/remote_story_dest_add.dart';
import 'package:diary_app_final/features/story/data/datadestinations/remote_story_dest_update.dart';
import 'package:diary_app_final/features/story/data/datasources/remote_story_source.dart';
import 'package:diary_app_final/features/story/data/datasources/remote_user_info_source.dart';
import 'package:diary_app_final/features/story/data/repositories/story_repository_impl.dart';
import 'package:diary_app_final/features/story/domain/repositories/repository.dart';
import 'package:diary_app_final/features/story/domain/usecases/add_story/add_story.dart';
import 'package:diary_app_final/features/story/domain/usecases/get_all_stories/get_all_stories.dart';
import 'package:diary_app_final/features/story/domain/usecases/get_user_info/get_user_info.dart';
import 'package:diary_app_final/features/story/domain/usecases/update_story/update_story.dart';
import 'package:diary_app_final/features/story/presentation/bloc/bloc_story/story_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'features/authentication/presentation/bloc/bloc_auth/bloc_auth_bloc.dart';
import 'features/story/presentation/bloc/cubit_story_list/stories_list_cubit.dart';

final sl = GetIt.instance;

init() {

  // bloc / cubit
  sl.registerFactory(() => BlocAuthBloc(signIn: sl(), logOut: sl(), signUp: sl()));
  sl.registerFactory(() => AuthCubit(firebaseAuth: sl()));
  sl.registerFactory(() => StoryBloc(getUserInfo: sl(),addStory: sl(), userId: sl(), firestore: sl(), updateStory: sl()));
  sl.registerFactory(() => StoriesListCubit(getAllStories: sl(), userId: sl()));
  // usecases
  sl.registerLazySingleton(() => LogOut(userRepository: sl()));
  sl.registerLazySingleton(() => SignIn(userRepository: sl()));
  sl.registerLazySingleton(() => SignUp(userRepository: sl()));
  sl.registerLazySingleton(() => GetUserInfo(storyRepository: sl()));
  sl.registerLazySingleton(() => GetAllStories(sl()));
  sl.registerLazySingleton(() => AddStory(storyRepository: sl()));
  sl.registerLazySingleton(() => UpdateStory(repository: sl()));
  // auth repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(fireAuthSignIn: sl(), fireAuthSignUp: sl(), fireAuthLogOut: sl(), networkInfo: sl()));
  sl.registerLazySingleton<FireAuthSignIn>(() => FireAuthSignInImpl(firebaseAuth: sl()));
  sl.registerLazySingleton<FireAuthLogOut>(() => FireAuthLogOutImpl(firebaseAuth: sl()));
  sl.registerLazySingleton<FireAuthSignUp>(() => FireAuthSignUpImpl(firebaseAuth: sl(), firestore: sl()));

  // story repository
  sl.registerLazySingleton<StoryRepository>(() => StoryRepositoryImpl(remoteUserInfoSource: sl(),remoteDataSource: sl(), networkInfo: sl(), remoteDataDestAdd: sl(), remoteDataDestUpdate: sl()));
  sl.registerLazySingleton<RemoteStorySource>(() => RemoteStorySourceImpl(firestore: sl()));
  sl.registerLazySingleton<RemoteStoryDestinationAdd>(() => RemoteStoryDestinationAddImpl(firestore: sl()));
  sl.registerLazySingleton<RemoteStoryDestUpdate>(() => RemoteStoryDestUpdateImpl(firestore: sl()));
  sl.registerLazySingleton<RemoteUserInfoSource>(() => RemoteUserInfoSourceImpl(firestore: sl()));
  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(checker: sl()));


  // external
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerFactory(() => FirebaseAuth.instance.currentUser!.uid);
  // sl.registerLazySingletonAsync(() => FirebaseFirestore.instance);
}