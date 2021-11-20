import 'package:todo_list/domain/models/todo.dart';

abstract class TodoDetailsState{
  Todo? get todo;
}

class TodoDetailsIsLoading extends TodoDetailsState{
  final Todo? _todo;

  TodoDetailsIsLoading({Todo? todo}):_todo = todo;

  @override
  Todo? get todo => _todo;
}

class TodoDetailsIsLoaded extends TodoDetailsState{
  final Todo? _todo;

  TodoDetailsIsLoaded({Todo? todo}):_todo = todo;

  @override
  Todo? get todo => _todo;
}

class TodoDetailsOnError extends TodoDetailsState{
  final Todo? _todo;
  final String error;

  TodoDetailsOnError(Todo? todo, this.error):_todo = todo;

  @override
  Todo? get todo => _todo;
}