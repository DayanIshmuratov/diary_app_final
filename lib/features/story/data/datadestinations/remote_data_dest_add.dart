import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app_final/features/story/data/models/story_model.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

abstract class RemoteDataDestinationAdd {
  void addStory(String userId, StoryEntity story){}
}
class RemoteDataDestinationAddImpl implements RemoteDataDestinationAdd {
  final FirebaseFirestore firestore;
  RemoteDataDestinationAddImpl({required this.firestore});
  @override
  void addStory(String userId, StoryEntity story) async {
    await firestore.collection("Users")
        .doc(userId)
        .collection("userStories")
        .doc()
        .set({"title" : story.title, "text" : story.text, "date" : story.date});
  }
  
}