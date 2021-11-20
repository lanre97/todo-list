import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/domain/repositories/todo_repository.dart';

import 'pages/todo_details/todo_details.dart';
import 'pages/todos/add_todo/add_todo.dart';
import 'pages/todos/todos.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme  = ThemeData();

    return RepositoryProvider<TodoRepository>(
      create: (context) => TodoRepositoryImpl(),
      child: Builder(
        builder: (context) {
          return BlocProvider<TodoListBloc>(
            create: (context) => TodoListBloc(
              repository: context.read<TodoRepository>()
            )..loadTodoList(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Todo List',
              theme: theme.copyWith(
                primaryColor: Colors.indigo.shade900,
                colorScheme: theme.colorScheme.copyWith(
                  primary: Colors.indigo.shade900,
                  secondary: Colors.indigo.shade900,       
                )
              ),
              routes: {
                '/': (context) => const TodosPage(),
                '/addTodo':(context) => const AddTodoPage(),
                '/todoDetails':(context) => const TodoDetailsPage(),
              },
            )
          );
        }
      ),
    );
  }
}