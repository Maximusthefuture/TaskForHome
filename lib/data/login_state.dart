import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_for_home/data/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasks_for_home/data/buy_todo_list.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

class LoginState extends ChangeNotifier {
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  String? _email;
  String get email => _email ?? "";

  StreamSubscription<QuerySnapshot>? _watchListSubscription;
  List<WatchListModel> _watchList = [];
  List<WatchListModel> get watchList => _watchList;

  LoginState() {
    init();
  }

  Future<void> addWatchList(WatchListModel watchList) {
    final restaurants = FirebaseFirestore.instance.collection('watch_list');
    return restaurants.add({
      'name': watchList.name,
      'posterPath': watchList.movieIcon,
    });
  }

  Future<void> addTodoList(BuyList todoList) {
    final todo = FirebaseFirestore.instance.collection('todo_list');
    return todo.add({
      'item': todoList.item,
      'category': todoList.category,
      'isDone': todoList.isChecked
    });
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _watchListSubscription = FirebaseFirestore.instance
            .collection('watch_list')
            .snapshots()
            .listen((snapshot) {
          _watchList = [];
          snapshot.docs.forEach((element) {
            var data = element.data();
            _watchList.add(WatchListModel(
                name: data['name'], movieIcon: data['posterPath']));
          });
          notifyListeners();
        });
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _watchList = [];
        _watchListSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void singInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("email", email);
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String displayName, String password,
      Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
