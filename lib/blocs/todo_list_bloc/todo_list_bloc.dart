import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_list_bloc/todo_list_state.dart';
import 'package:todo_list/domain/models/todo.dart';
import 'package:todo_list/domain/repositories/todo_repository.dart';

class TodoListBloc extends Cubit<TodoListState>{

  final TodoRepository _repository;

  TodoListBloc({
    required TodoRepository repository
    }) : _repository = repository, super(TodoListIsLoading());
  
  loadTodoList() async{
    emit(TodoListIsLoading());
    try{
      final todoList = await _repository.getTodos();
      emit(TodoListIsLoaded(todos:todoList));
    }catch(e){
      emit(TodoListOnError(error:e.toString()));
    }
  }

  addTodo(Todo todo) async{
    emit(TodoListIsLoading());
    try{
      final id = await _repository.addTodo(todo);
      final newTodo = todo.copyWith(id:id);
      if(state is TodoListIsLoaded){
        final todoList = (state as TodoListIsLoaded).todos;
        emit(TodoListIsLoaded(todos:todoList??[]..add(newTodo)));
      }else{
        loadTodoList();
      }
    }catch(e){
      emit(TodoListOnError(error:e.toString(), todos:state.todos??[]));
    }
  }

  deleteTodo(Todo todo) async{
    emit(TodoListIsLoading());
    try{
      await _repository.deleteTodo(todo.id!);
      final todoList = (state as TodoListIsLoaded).todos;
      final newTodoList = [...todoList??[]];
      newTodoList.removeWhere((element) => element.id == todo.id);
      emit(TodoListIsLoaded(todos:newTodoList.cast<Todo>()));
    }catch(e){
      emit(TodoListOnError(error:e.toString(), todos:state.todos));
    }
  }

  updateTodo(Todo updatedTodo) async{
    emit(TodoListIsLoading());
    try{
      await _repository.updateTodo(updatedTodo);
      final todoList = (state as TodoListIsLoaded).todos;
      final newTodoList = todoList?.map((todo) => todo.id == todo.id ? updatedTodo : todo).toList();
      emit(TodoListIsLoaded(todos:newTodoList??[]));
    }catch(e){
      emit(TodoListOnError(error:e.toString(), todos:state.todos));
    }
  }

}