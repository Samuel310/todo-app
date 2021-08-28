part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class OnAddTodoBtnClicked extends TodoEvent {
  final Todo todo;
  OnAddTodoBtnClicked({required this.todo});
}

class OnUpdateTodoBtnClicked extends TodoEvent {
  final Todo todo;
  final String id;
  OnUpdateTodoBtnClicked({required this.todo, required this.id});
}

class OnDeleteTodoBtnClicked extends TodoEvent {
  final String id;
  OnDeleteTodoBtnClicked({required this.id});
}

class OnMarkAsDoneBtnClicked extends TodoEvent {
  final String id;
  OnMarkAsDoneBtnClicked({required this.id});
}
