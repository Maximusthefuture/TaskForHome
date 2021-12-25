import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/login_state.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

class Helpers {
  static void showSnackBar(MovieDetails? snapshot, String message, BuildContext context) {
  final snackBar = SnackBar(
      content:
          Text("${snapshot?.title ?? snapshot?.title} ${message}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

static void showSnackBarInSearch(Results? snapshot, String message, BuildContext context) {
  final snackBar = SnackBar(
      content:
          Text("${snapshot?.title ?? snapshot?.title} ${message}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

static Future<bool> checkMovieId(int? snapshotMovieId) async {
  bool isHere = false;
  var movies = FirebaseFirestore.instance.collection("watch_list");
  await movies.get().then((value) {
    value.docs.forEach((doc) {
      if (doc["movieId"] == snapshotMovieId) {
        print("movieId ${doc["movieId"]}");
        isHere = true;
      }
    });
  });
  return isHere;
}

static void addToWatchList<T extends MovieDetails>(
    LoginState appState, T? snapshot, BuildContext context) async {
  var name = FirebaseAuth.instance.currentUser?.displayName;
  bool isInList = await Helpers.checkMovieId(snapshot?.id);
  
  if (isInList) {
    // ScaffoldMessenger.of(context).showSnackBar(snackBarFalse);
    Helpers.showSnackBar(snapshot, "already in list", context);
  } else {
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Helpers.showSnackBar(snapshot, "added in list", context);
    appState.addWatchList(WatchListModel(
        name: name,
        movieIcon: snapshot?.posterPath,
        movieName: snapshot?.title,
        movieId: snapshot?.id));
  }
}

static void addToWatchListInSearch<T extends Results>(
    LoginState appState, T? snapshot, BuildContext context) async {
  var name = FirebaseAuth.instance.currentUser?.displayName;
  bool isInList = await Helpers.checkMovieId(snapshot?.id);
  
  if (isInList) {
    // ScaffoldMessenger.of(context).showSnackBar(snackBarFalse);
    Helpers.showSnackBarInSearch(snapshot, "already in list", context);
  } else {
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Helpers.showSnackBarInSearch(snapshot, "added in list", context);
    appState.addWatchList(WatchListModel(
        name: name,
        movieIcon: snapshot?.posterPath,
        movieName: snapshot?.title,
        movieId: snapshot?.id));
  }
}
}