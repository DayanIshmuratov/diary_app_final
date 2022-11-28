import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/exception.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/core/platform/network_info.dart';
import 'package:diary_app_final/features/story/data/datadestinations/remote_story_dest_update.dart';
import 'package:diary_app_final/features/story/data/datasources/remote_story_source.dart';
import 'package:diary_app_final/features/story/data/datasources/remote_user_info_source.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';
import 'package:diary_app_final/features/story/domain/entities/user_info_entity.dart';
import 'package:diary_app_final/features/story/domain/repositories/repository.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

import '../datadestinations/remote_story_dest_add.dart';
import '../models/story_model.dart';

class StoryRepositoryImpl implements StoryRepository {
  @override
  final RemoteStorySource remoteDataSource;
  final NetworkInfo networkInfo;
  final RemoteStoryDestinationAdd remoteDataDestAdd;
  final RemoteStoryDestUpdate remoteDataDestUpdate;
  final RemoteUserInfoSource remoteUserInfoSource;

  StoryRepositoryImpl({
    required this.remoteDataSource, required this.networkInfo, required this.remoteDataDestAdd, required this.remoteDataDestUpdate, required this.remoteUserInfoSource});

  @override
  Future<Either<Failure, List<StoryEntity>>> getStories(String userId) async {
    return await _getData<List<StoryEntity>>(() => remoteDataSource.getAllStories(userId));
  }

  Future<Either<Failure, UserInfoEntity>> getUserInfo(String userId) async {
    return await _getData<UserInfoEntity>(() => remoteUserInfoSource.getUserInfo(userId));
  }

  Future<Either<Failure, T>> _getData<T>(
      Future<T> Function() getData) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await getData();
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }


  void addStory(String userId, StoryEntity story, int counter) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataDestAdd.addStory(userId, story, counter);
      } on ServerException {
        throw ServerFailure();
      }
    }
  }

  @override
  void updateStory(String userId, StoryEntity story) {
    remoteDataDestUpdate.update(userId, story);
  }



}