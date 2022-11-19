import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/exception.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/core/platform/network_info.dart';
import 'package:diary_app_final/features/story/data/datasources/remote_data_source.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';
import 'package:diary_app_final/features/story/domain/repositories/repository.dart';

import '../datadestinations/remote_data_dest_add.dart';
import '../models/story_model.dart';

class StoryRepositoryImpl implements StoryRepository {
  @override
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final RemoteDataDestinationAdd remoteDataDestinationSave;

  StoryRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo, required this.remoteDataDestinationSave});

  @override
  Future<Either<Failure, List<StoryEntity>>> getStories(String userId) async {
    return await _getStory(() => remoteDataSource.getAllStories(userId));
  }

  void addStory(String userId, StoryEntity story) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataDestinationSave.addStory(userId, story);
      } on ServerException {
        throw ServerFailure();
      }
    }
  }


  Future<Either<Failure, List<StoryEntity>>> _getStory(
      Future<List<StoryEntity>> Function() getStories) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteStories = await getStories();
        return Right(remoteStories);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }
}