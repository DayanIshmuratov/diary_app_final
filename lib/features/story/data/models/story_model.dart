import 'package:diary_app_final/features/story/domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  String title;
  String text;
  dynamic date;

  StoryModel({required this.title, required this.text, required this.date})
      : super(title: title, text: text, date: date);

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
        title: json["title"],
        text: json["text"],
        date: json['date']);
  }

  Map<String, dynamic> toJson(StoryModel story) {
    return {
      "title" : story.title,
      "text" : story.text,
      "date" : story.date,
    };
  }
}
