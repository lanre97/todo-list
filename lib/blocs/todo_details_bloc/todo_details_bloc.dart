import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_details_bloc/todo_details_state.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/domain/models/todo.dart';
import 'package:todo_list/domain/repositories/todo_repository.dart';

class TodoDetailsBloc extends Cubit<TodoDetailsState>{

  final TodoRepository _todoRepository;

  TodoDetailsBloc({required TodoRepository todoRepository}) : 
    _todoRepository = todoRepository, 
    super(TodoDetailsIsLoading());

  init(Todo todo){
    emit(TodoDetailsIsLoading());
    _todoRepository.getTasks(todo.id!).then((tasks){
      emit(TodoDetailsIsLoaded(todo: todo.copyWith(tasks: tasks)));
    }).catchError((error){
      emit(TodoDetailsOnError(todo,error));
    });
  }

  addTask(String idTodo, Task task){
    emit(TodoDetailsIsLoading());
    _todoRepository.addTask(idTodo, task).then((value){
      _todoRepository.getTasks(idTodo).then((tasks){
        emit(TodoDetailsIsLoaded(todo: Todo(id: idTodo, tasks: tasks)));
      }).catchError((error){
        emit(TodoDetailsOnError(Todo(id: idTodo),error));
      });
    }).catchError((error){
      emit(TodoDetailsOnError(state.todo,error.toString()));
    });
  }

  deleteTask(String idTodo, String idTask){
    emit(TodoDetailsIsLoading());
    _todoRepository.deleteTask(idTodo, idTask).then((value){
      _todoRepository.getTasks(idTodo).then((tasks){
        emit(TodoDetailsIsLoaded(todo: Todo(id: idTodo, tasks: tasks)));
      }).catchError((error){
        emit(TodoDetailsOnError(Todo(id: idTodo),error));
      });
    }).catchError((error){
      emit(TodoDetailsOnError(state.todo,error.toString()));
    });
  }

  updateTaks(String idTodo, Task task){
    _todoRepository.updateTask(idTodo, task).then((value){
      _todoRepository.getTasks(idTodo).then((tasks){
        emit(TodoDetailsIsLoaded(todo: Todo(id: idTodo, tasks: tasks)));
      }).catchError((error){
        emit(TodoDetailsOnError(Todo(id: idTodo),error));
      });
    }).catchError((error){
      emit(TodoDetailsOnError(state.todo,error.toString()));
    });
  }

}