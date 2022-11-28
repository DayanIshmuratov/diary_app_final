import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app_final/features/story/data/models/story_model.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

abstract class RemoteStoryDestinationAdd {
  void addStory(String userId, StoryEntity story, int counter){}
}
class RemoteStoryDestinationAddImpl implements RemoteStoryDestinationAdd {
  final FirebaseFirestore firestore;
  RemoteStoryDestinationAddImpl({required this.firestore});
  @override
  void addStory(String userId, StoryEntity story, int counter) async {
    await firestore.collection("Users")
        .doc(userId)
        .collection("userStories")
        .doc('${(counter + 1).toString()}')
        .set({"title" : story.title, "text" : story.text, "date" : story.date});

    await FirebaseFirestore.instance.collection("Users")
        .doc(userId)
        .update({"counterOfStory": FieldValue.increment(1)});
  }
}