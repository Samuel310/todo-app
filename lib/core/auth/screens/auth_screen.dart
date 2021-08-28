import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/auth/screens/login_screen.dart';
import 'package:todo/core/todo/screens/todo_list_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('Auth error: ${snapshot.error.toString()}'),
              ),
            );
          } else if (snapshot.data != null) {
            return TodoListScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
