import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/blocs/todo_list_bloc/todo_list_state.dart';
import 'package:todo_list/presentation/utils/dialogs.dart';
import 'package:todo_list/presentation/utils/navigate.dart';
import 'package:todo_list/presentation/widgets/todos.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis pendientes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          navigateToAddTodo(context);
        }
      ),
      body: BlocBuilder<TodoListBloc,TodoListState>(
        builder: (context,state){
          if(state is TodoListIsLoading){
            return const Center(child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ));
          }else if(state is TodoListOnError){
            return const Center(child: Text('Error', style: TextStyle(color: Colors.red)));
          }
          return state.todos?.isEmpty?? false?
          const Center(child:Text('No hay pendientes')) : 
          GridView.builder(
            itemCount: state.todos?.length,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 50.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (context,index){
              return TodoStick(
                color: Color(state.todos![index].color??Colors.yellow.value), 
                title: state.todos![index].title??"",
                onTap: (){
                  navigateToTodoDetails(context, state.todos![index]);
                },
                onLongPress: () async{
                  showYesNoDialog(
                    context, 
                    title: "Eliminar tarea", 
                    content: "¿Estás seguro de que deseas eliminar esta tarea?"
                    )
                  .then((verify){
                    if(verify){
                      context.read<TodoListBloc>().deleteTodo(state.todos![index]);
                    }
                  });
                },
              );
            }, 
          );
        }
      )
    );
  }
}