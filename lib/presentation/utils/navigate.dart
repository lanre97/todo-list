import 'package:flutter/material.dart';
import 'package:todo_list/domain/models/todo.dart';

navigateToAddTodo(BuildContext context) {
  Navigator.pushNamed(context, '/addTodo');
}

navigateToTodoDetails(BuildContext context, Todo todo){
  Navigator.pushNamed(context, '/todoDetails', arguments: todo);
}
