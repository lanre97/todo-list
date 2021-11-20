import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/domain/models/todo.dart';

abstract class TodoRepository{
  Future<List<Todo>> getTodos();
  Future<Todo> getTodo(String id);
  Future<String> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<String> addTask(String idTodo, Task task);
  Future<void> updateTask(String idTodo, Task task);
  Future<void> deleteTask(String idTodo, String idTask);
  Future<List<Task>> getTasks(String idTodo);
}

class TodoRepositoryImpl implements TodoRepository{
  static final CollectionReference _collection = 
    FirebaseFirestore.instance.collection('todo');

  @override
  Future<String> addTodo(Todo todo) async{
    var id = await FirebaseFirestore.instance.runTransaction<String>((transaction) async{
      final ref = _collection.doc();
      transaction.set(ref, todo.toJson());
      todo.tasks?.forEach((element) {
        final taskRef = ref.collection('tasks').doc();
        transaction.set(taskRef, element.toJson());
      });
      return ref.id;
    });
    return id;
  }

  @override
  Future<void> deleteTodo(String id) {
    return _collection.doc(id).delete();
  }

  @override
  Future<Todo> getTodo(String id) async {
    return await _collection.doc(id).get().then((snapshot){
      final json = snapshot.data() as Map<String,dynamic>
      ..addAll({'id':snapshot.id});
      return Todo.fromJson(json);
    });
  }

  @override
  Future<List<Todo>> getTodos() {
    return _collection.get().then((snapshot){
      return snapshot.docs.map((doc){
        final json = doc.data() as Map<String,dynamic>
        ..addAll({'id': doc.id});
        return Todo.fromJson(json);
      }).toList();
    });
  }

  @override
  Future<void> updateTodo(Todo todo) {
    return _collection.doc(todo.id).update(todo.toJson());
  }

  @override
  Future<String> addTask(String idTodo, Task task) {
    return _collection.doc(idTodo).collection('tasks').add(task.toJson()).then((reference){
      return reference.id;
    });
  }

  @override
  Future<void> deleteTask(String idTodo, String idTask) {
    return _collection.doc(idTodo).collection('tasks').doc(idTask).delete();
  }

  @override
  Future<void> updateTask(String idTodo, Task task) {
    return _collection.doc(idTodo).collection('tasks').doc(task.id).update(task.toJson());
  }

  @override
  Future<List<Task>> getTasks(String idTodo) {
    return _collection.doc(idTodo).collection('tasks').get().then((snapshot){
      return snapshot.docs.map((doc){
        final json = doc.data()..addAll({'id': doc.id});
        return Task.fromJson(json);
      }).toList();
    });
  }

}