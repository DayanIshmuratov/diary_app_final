import 'package:diary_app_final/features/story/presentation/widgets/story_write.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adding story")),
      body: StoryWrite(),
    );
  }
}