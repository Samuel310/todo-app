import 'package:flutter/material.dart';
import 'package:todo/core/todo/bloc/todo_bloc.dart';
import 'package:todo/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/utils/form_validator.dart';

class ManageTodo extends StatelessWidget {
  final Todo? todo;
  ManageTodo({this.todo, Key? key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      titleController.text = todo!.title;
      descriptionController.text = todo!.description;
    }
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is ErrorWhileAddingState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        } else if (state is ErrorWhileDeletingState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        } else if (state is NewTodoAddedState) {
          Navigator.pop(context);
        } else if (state is TodoDeletedState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Todo'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        controller: titleController,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        validator: FormValidator.validateTitle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: descriptionController,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          validator: FormValidator.validateDescription,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          if (state is AddingInProgressState) {
                            return CircularProgressIndicator();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (todo != null) {
                                  Todo newTodo = Todo(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    createdOn: DateTime.now().toLocal(),
                                    id: todo!.id!,
                                  );
                                  context.read<TodoBloc>().add(OnUpdateTodoBtnClicked(todo: newTodo, id: todo!.id!));
                                } else {
                                  Todo newTodo = Todo(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    createdOn: DateTime.now().toLocal(),
                                  );
                                  context.read<TodoBloc>().add(OnAddTodoBtnClicked(todo: newTodo));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(todo != null ? 'Update' : 'Add'),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 20),
                      Visibility(
                        visible: todo != null,
                        child: BlocBuilder<TodoBloc, TodoState>(
                          builder: (context, state) {
                            if (state is DeletingInProgressState) {
                              return CircularProgressIndicator();
                            }
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                context.read<TodoBloc>().add(OnDeleteTodoBtnClicked(id: todo!.id!));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('Delete'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
