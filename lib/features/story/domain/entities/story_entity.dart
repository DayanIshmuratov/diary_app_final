class StoryEntity {
  String? docId;
  String title;
  String text;
  dynamic date;

  StoryEntity({this.docId, required this.title, required this.text, required this.date});
}
