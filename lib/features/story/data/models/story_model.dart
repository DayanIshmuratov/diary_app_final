import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  String? docId;
  String title;
  String text;
  dynamic date;

  StoryModel({this.docId, required this.title, required this.text, required this.date})
      : super(docId: docId, title: title, text: text, date: date);

  factory StoryModel.fromDoc(QueryDocumentSnapshot doc) {
    return StoryModel(
        title: doc["title"],
        text: doc["text"],
        date: doc['date'],
        docId: doc.id,
        // docId: json['docId'],
        // counter: json['counter'],
    );
  }

  Map<String, dynamic> toJson(StoryModel story) {
    return {
      "title" : story.title,
      "text" : story.text,
      "date" : story.date,
      "docId" : story.docId,
      // "counter" : story.counter,
      // "docId" : story.docId,
    };
  }
}
