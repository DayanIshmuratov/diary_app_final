import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app_final/core/error/exception.dart';

import '../models/story_model.dart';

abstract class RemoteDataSource{
  Future<List<StoryModel>> getAllStories(String userId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  FirebaseFirestore firestore;
  RemoteDataSourceImpl({required this.firestore});
  @override
  Future<List<StoryModel>> getAllStories(String userId) async {
        final stories = await firestore.collection("Users")
            .doc(userId)
            .collection("userStories")
            .get().then((QuerySnapshot querySnapshot) => querySnapshot.docs.map((e) => StoryModel.fromDoc(e)).toList());
        return stories;
  }
}