import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';
import 'package:diary_app_final/features/story/domain/entities/user_info_entity.dart';

abstract class StoryRepository {
  Future<Either<Failure, List<StoryEntity>>> getStories(String userId);
  Future<Either<Failure, UserInfoEntity>> getUserInfo(String userId);
  void addStory(String userId, StoryEntity story, int counter);
  void updateStory(String userId, StoryEntity story);
}

