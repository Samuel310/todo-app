import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/todo/repository/todo_repo.dart';
import 'package:todo/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  late TodoRepository repository;
  TodoBloc({required this.repository}) : super(TodoInitialState(todoList: repository.todoList));

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is LoadTodos) {
      try {
        yield LoadingTodoState();
        await repository.loadTodos();
        yield TodoInitialState(todoList: repository.todoList);
      } catch (e) {
        yield ErrorWhileLoadingTodoState(errorMsg: e.toString(), todoList: repository.todoList);
      }
    } else if (event is OnAddTodoBtnClicked) {
      try {
        yield AddingInProgressState(todoList: repository.todoList);
        await repository.addTodo(todo: event.todo);
        yield NewTodoAddedState(todoList: repository.todoList);
      } catch (e) {
        yield ErrorWhileAddingState(errorMsg: e.toString(), todoList: repository.todoList);
      }
    } else if (event is OnDeleteTodoBtnClicked) {
      try {
        yield DeletingInProgressState(todoList: repository.todoList);
        await repository.deleteTodo(id: event.id);
        yield TodoDeletedState(todoList: repository.todoList);
      } catch (e) {
        yield ErrorWhileDeletingState(errorMsg: e.toString(), todoList: repository.todoList);
      }
    } else if (event is OnMarkAsDoneBtnClicked) {
      try {
        yield MakingAsDoneInProgressState(todoList: repository.todoList);
        await repository.markTodoAsDone(id: event.id);
        yield MarkedAsDoneState(todoList: repository.todoList);
      } catch (e) {
        yield ErrorWhileMakingAsDoneState(errorMsg: e.toString(), todoList: repository.todoList);
      }
    } else if (event is OnUpdateTodoBtnClicked) {
      try {
        yield AddingInProgressState(todoList: repository.todoList);
        await repository.updateTodo(todo: event.todo, id: event.id);
        yield NewTodoAddedState(todoList: repository.todoList);
      } catch (e) {
        yield ErrorWhileAddingState(errorMsg: e.toString(), todoList: repository.todoList);
      }
    }
  }
}
