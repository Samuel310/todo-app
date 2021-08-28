import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/theme_bloc.dart';
import 'package:todo/config/routes/route_config.dart';
import 'package:todo/core/auth/bloc/auth_bloc.dart';
import 'package:todo/core/auth/repository/auth_repository.dart';
import 'package:todo/core/todo/bloc/todo_bloc.dart';
import 'package:todo/core/todo/repository/todo_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(repository: AuthRepository())),
        BlocProvider<TodoBloc>(create: (context) => TodoBloc(repository: TodoRepository())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: state.isDark ? Colors.grey[900] : Colors.blue,
              primaryColorBrightness: state.isDark ? Brightness.dark : Brightness.light,
              primaryColorLight: state.isDark ? Colors.grey[900] : Colors.white,
              brightness: state.isDark ? Brightness.dark : Brightness.light,
              primaryColorDark: state.isDark ? Colors.grey[900] : Colors.black,
              indicatorColor: state.isDark ? Colors.white : Colors.grey,
              canvasColor: state.isDark ? Colors.grey[850] : Colors.white,
              toggleableActiveColor: Colors.blue,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: state.isDark ? Colors.grey[900] : Colors.blue,
                foregroundColor: state.isDark ? Colors.blue : Colors.white,
              ),
              appBarTheme: AppBarTheme(
                brightness: state.isDark ? Brightness.dark : Brightness.light,
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.AUTHENTICATE_SCREEN,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}

//todo: integrate update feature
//todo: add validation
//todo: structure theme logics
//todo: auth logics and design
