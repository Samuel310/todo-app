import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/auth/screens/auth_screen.dart';
import 'package:todo/core/auth/screens/login_screen.dart';
import 'package:todo/core/auth/screens/signup_screen.dart';
import 'package:todo/core/settings/screens/settings_screens.dart';
import 'package:todo/core/todo/screens/manage_todo_screen.dart';
import 'package:todo/core/todo/screens/todo_list_screen.dart';
import 'package:todo/models/todo_model.dart';

class Routes {
  static const AUTHENTICATE_SCREEN = '/auth';
  static const LOGIN_SCREEN = '/login';
  static const SIGNUP_SCREEN = '/signup';
  static const TODO_LIST_SCREEN = '/todo';
  static const SETTINGS_SCREEN = '/settings';
  static const MANAGE_TODO_SCREEN = '/manage-todo';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AUTHENTICATE_SCREEN:
        return MaterialPageRoute(builder: (context) => AuthScreen());
      case TODO_LIST_SCREEN:
        return MaterialPageRoute(builder: (context) => TodoListScreen());
      case LOGIN_SCREEN:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case SETTINGS_SCREEN:
        return MaterialPageRoute(builder: (context) => SettingsScreen());
      case MANAGE_TODO_SCREEN:
        return MaterialPageRoute(builder: (context) => ManageTodo(todo: settings.arguments as Todo?));
      case SIGNUP_SCREEN:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Container(
              child: Center(
                child: Text('Unauthorized access'),
              ),
            ),
          ),
        );
    }
  }
}
