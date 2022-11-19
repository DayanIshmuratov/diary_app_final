import 'package:dartz/dartz.dart';
import 'package:diary_app_final/core/error/failure.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';
import 'package:diary_app_final/features/story/domain/repositories/repository.dart';


class GetAllStories {
  final StoryRepository repositoryToGet;
  GetAllStories(this.repositoryToGet);
  Future<Either<Failure, List<StoryEntity>>> call(String userId) async {
     return await repositoryToGet.getStories(userId);
  }
}