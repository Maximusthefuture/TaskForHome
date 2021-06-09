import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_for_home/data/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasks_for_home/data/watch_list_model.dart';

class LoginState extends ChangeNotifier {
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  String? _email;
  String get email => _email ?? "";

  StreamSubscription<QuerySnapshot>? _watchListSubscription;
  List<WatchListData> _watchList = [];
  List<WatchListData> get watchList => _watchList;

  LoginState() {
    init();
  }

  Future<DocumentReference> addToWatchList(List list) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception("Must be logged in");
    }
    CollectionReference watchList =
        FirebaseFirestore.instance.collection('watch_list');
    return watchList.add({
      'recommendation': list,
      'name': FirebaseAuth.instance.currentUser!.displayName
    });
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _watchListSubscription = FirebaseFirestore.instance
            .collection('watch_list')
            .snapshots()
            .listen((snapshot) {
          _watchList = [];
          snapshot.docs.forEach((element) {
            var data = element.data();
            _watchList.add(WatchListData(
                name: data['name'], movieList: data['recommendation']));
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
