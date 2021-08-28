import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/config/routes/route_config.dart';
import 'package:todo/core/todo/bloc/todo_bloc.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(LoadTodos());
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is ErrorWhileDeletingState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        } else if (state is ErrorWhileMakingAsDoneState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.note_alt_sharp),
          title: Text('Todo'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.SETTINGS_SCREEN);
              },
              splashRadius: 20,
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is LoadingTodoState) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.todoList.isEmpty) {
              return Container(
                child: Center(
                  child: Text(
                    "No todo's found",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TodoBloc>().add(LoadTodos());
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemCount: state.todoList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 5);
                  },
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 10,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            state.todoList[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              'Created on: ${state.todoList[index].createdOn.toString()}',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Visibility(
                              visible: state.todoList[index].completedOn != null,
                              child: Text(
                                'Completed on: ${state.todoList[index].completedOn.toString()}',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              state.todoList[index].description,
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: state.todoList[index].completedOn != null,
                              onChanged: (value) {
                                context.read<TodoBloc>().add(OnMarkAsDoneBtnClicked(id: state.todoList[index].id ?? ''));
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                if (!(state is DeletingInProgressState)) {
                                  context.read<TodoBloc>().add(OnDeleteTodoBtnClicked(id: state.todoList[index].id ?? ''));
                                }
                              },
                              icon: Icon(Icons.delete),
                              splashRadius: 20,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, Routes.MANAGE_TODO_SCREEN, arguments: state.todoList[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.MANAGE_TODO_SCREEN);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
