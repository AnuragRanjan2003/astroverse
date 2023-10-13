import 'dart:io';

import 'package:astroverse/db/db.dart';
import 'package:astroverse/db/storage.dart';
import 'package:astroverse/models/save_service.dart';
import 'package:astroverse/models/service.dart';
import 'package:astroverse/utils/resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRepo {
  final _db = Database();
  final _storage = Storage();

  Future<Resource<Service>> saveService(Service post, String uid) async =>
      await _db.saveService(post, uid);

  Future<Resource<String>> storeServiceImage(File file, String id) async =>
      await _storage.storeServiceImage(file, id);

  Future<Resource<List<QueryDocumentSnapshot<Service>>>>
      fetchPostsByGenreAndPage(List<String> genre, String uid) async =>
          await _db.fetchServiceByGenreAndPage(genre, uid);

  Future<Resource<List<QueryDocumentSnapshot<Service>>>> fetchMorePost(
          QueryDocumentSnapshot<Service> lastPost,
          List<String> genre,
          String uid) async =>
      await _db.fetchMoreService(lastPost, genre, uid);

  Future<Resource<int>> increaseVote(String id, String uid) async =>
      await _db.increaseServiceVote(uid, id);

  Future<Resource<int>> decreaseVote(String id, String uid) async =>
      await _db.decreaseServiceVote(uid, id);

  Stream<QuerySnapshot<SaveService>> upVotedPostStream(String uid) =>
      _db.upVotedServicesStream(uid);
}