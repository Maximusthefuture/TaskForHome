import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_for_home/data/authentication.dart';
import 'package:tasks_for_home/data/login_state.dart';

class SettingsScreeen extends StatelessWidget {
  const SettingsScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingWidget()
    ;
  }
}

class SettingWidget extends StatelessWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 50,
                child: FutureBuilder<String>(
                    future: getMail(),
                    builder: (context, snapshot) {
                      return Text(snapshot.data ?? "NULL");
                    }),
              ),
              Container(
                height: 300,
                width: 300,
                child: Consumer<LoginState>(
                  builder: (context, appState, _) => Authentication(
                    email: appState.email,
                    loginState: appState.loginState,
                    startLoginFlow: appState.startLoginFlow,
                    verifyEmail: appState.verifyEmail,
                    signInWithEmailAndPassword:
                    appState.singInWithEmailAndPassword,
                    cancelRegistration: appState.cancelRegistration,
                    registerAccount: appState.registerAccount,
                    signOut: appState.signOut,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

Future<String> getMail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString("email");
  return email ?? "";
}
