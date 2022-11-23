import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

abstract class StoryRepository {
  Future<Either<Failure, List<StoryEntity>>> getStories(String userId);
  void addStory(String userId, StoryEntity story, int counter);
  // void updateStory(String userId, List<StoryEntity> story, docId);
}

