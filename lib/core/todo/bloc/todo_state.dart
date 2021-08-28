part of 'todo_bloc.dart';

@immutable
abstract class TodoState {
  final List<Todo> todoList;
  TodoState({required this.todoList});
}

class TodoInitialState extends TodoState {
  TodoInitialState({required List<Todo> todoList}) : super(todoList: todoList);
}

class LoadingTodoState extends TodoState {
  LoadingTodoState() : super(todoList: []);
}

class ErrorWhileLoadingTodoState extends TodoState {
  final String errorMsg;
  ErrorWhileLoadingTodoState({required this.errorMsg, required List<Todo> todoList}) : super(todoList: todoList);
}

class AddingInProgressState extends TodoState {
  AddingInProgressState({required List<Todo> todoList}) : super(todoList: todoList);
}

class NewTodoAddedState extends TodoState {
  NewTodoAddedState({required List<Todo> todoList}) : super(todoList: todoList);
}

class ErrorWhileAddingState extends TodoState {
  final String errorMsg;
  ErrorWhileAddingState({required this.errorMsg, required List<Todo> todoList}) : super(todoList: todoList);
}

class DeletingInProgressState extends TodoState {
  DeletingInProgressState({required List<Todo> todoList}) : super(todoList: todoList);
}

class TodoDeletedState extends TodoState {
  TodoDeletedState({required List<Todo> todoList}) : super(todoList: todoList);
}

class ErrorWhileDeletingState extends TodoState {
  final String errorMsg;
  ErrorWhileDeletingState({required this.errorMsg, required List<Todo> todoList}) : super(todoList: todoList);
}

class MakingAsDoneInProgressState extends TodoState {
  MakingAsDoneInProgressState({required List<Todo> todoList}) : super(todoList: todoList);
}

class MarkedAsDoneState extends TodoState {
  MarkedAsDoneState({required List<Todo> todoList}) : super(todoList: todoList);
}

class ErrorWhileMakingAsDoneState extends TodoState {
  final String errorMsg;
  ErrorWhileMakingAsDoneState({required this.errorMsg, required List<Todo> todoList}) : super(todoList: todoList);
}
