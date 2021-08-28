import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/todo_model.dart';

class TodoRepository {
  late FirebaseFirestore _firestore;

  late List<Todo> todoList;

  TodoRepository() {
    _firestore = FirebaseFirestore.instance;
    todoList = [];
  }

  Future<void> loadTodos() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await _firestore.collection(user.uid).get();
        if (querySnapshot.docs.isNotEmpty) {
          todoList.clear();
          querySnapshot.docs.forEach((element) {
            Todo todo = Todo.fromMap(element.data() as Map<String, dynamic>);
            todo.id = element.id;
            todoList.add(todo);
          });
        }
      } catch (e) {
        print(e.toString());
        return Future.error("Unable to get all todo's at this time");
      }
    } else {
      return Future.error('No user found');
    }
  }

  Future<void> addTodo({required Todo todo}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentReference documentReference = await _firestore.collection(user.uid).add(todo.toMap());
        todo.id = documentReference.id;
        todoList.add(todo);
      } catch (e) {
        print(e.toString());
        return Future.error('Unable to add at this time');
      }
    } else {
      return Future.error('No user found');
    }
  }

  Future<void> deleteTodo({required String id}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _firestore.collection(user.uid).doc(id).delete();
        todoList.removeWhere((todo) => todo.id == id);
      } catch (e) {
        print(e.toString());
        return Future.error('Unable to delete at this time');
      }
    } else {
      return Future.error('No user found');
    }
  }

  Future<void> updateTodo({required Todo todo, required String id}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        int index = todoList.indexWhere((td) => td.id == id);
        if (index >= 0) {
          todoList.removeAt(index);
          todoList.insert(index, todo);
          await _firestore.collection(user.uid).doc(id).set(todo.toMap());
        }
      } catch (e) {
        print(e.toString());
        return Future.error('Unable to update at this time');
      }
    } else {
      return Future.error('No user found');
    }
  }

  Future<void> markTodoAsDone({required String id}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        int index = todoList.indexWhere((td) => td.id == id);
        if (index >= 0) {
          if (todoList[index].completedOn != null) {
            todoList[index].completedOn = null;
          } else {
            todoList[index].completedOn = DateTime.now().toLocal();
          }
          await _firestore.collection(user.uid).doc(id).set(todoList[index].toMap());
        }
      } catch (e) {
        print(e.toString());
        return Future.error('Unable to update at this time');
      }
    } else {
      return Future.error('No user found');
    }
  }
}
