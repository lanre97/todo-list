import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/domain/models/todo.dart';

class AddTodoBloc extends Cubit<Todo>{

  AddTodoBloc() : super(Todo(color:Colors.yellow.value,tasks: []));

  updateTitle(String title){
    emit(state.copyWith(title: title));
  }

  updateDescription(String description){
    emit(state.copyWith(description: description));
  }

  updateColor(Color color){
    emit(state.copyWith(color: color.value));
  }

  addTask(Task task){
    emit(state.copyWith(tasks: [...state.tasks??[],task]));
  }

  deleteTask(Task task){
    emit(state.copyWith(tasks: state.tasks?..remove(task)));
  }
  
}