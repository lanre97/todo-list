import 'package:todo_list/domain/models/todo.dart';

abstract class TodoListState{
  List<Todo>? get todos;
}

class TodoListIsLoading extends TodoListState{
  final List<Todo>? _todos;

  @override
  List<Todo>? get todos => _todos;

  TodoListIsLoading({List<Todo>? todos}): _todos = todos;
}

class TodoListIsLoaded extends TodoListState{
  final List<Todo> _todos;
  
  @override
  List<Todo>? get todos => _todos.where((todo) => !todo.isDone).toList();
  List<Todo>? get todosFinished => _todos.where((todo) => todo.isDone).toList();

  TodoListIsLoaded({required List<Todo> todos}): _todos = todos;
}

class TodoListOnError extends TodoListState{
  final String error;
  final List<Todo>? _todos;

  @override
  List<Todo>? get todos => _todos;

  TodoListOnError({required this.error, List<Todo>? todos}): _todos = todos;
}

