import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/add_todo_bloc/add_todo_bloc.dart';
import 'package:todo_list/blocs/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/domain/models/todo.dart';
import 'package:todo_list/presentation/utils/dialogs.dart';
import 'package:todo_list/presentation/widgets/todos.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTodoBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agregar pendiente'),
        ),
        body: TodoForm(),
      ),
    );
  }
}

class TodoForm extends StatelessWidget {

  TodoForm({ Key? key }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTodoBloc,Todo>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal:16),
                  children: [
                    InkWell(
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          height:150, width: 150,
                          child: TodoStick(
                            title: state.title??"",
                            color: Color(state.color??Colors.yellow.value),
                          ),
                        ),
                      ),
                      onTap: (){
                        showColorPicker(context).then((color){
                          if(color!=null){
                            context.read<AddTodoBloc>().updateColor(color);
                          }
                        });
                      },
                    ),
                    TextFormField(
                      maxLength: 40,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                      validator: (value) {
                        if (value?.isEmpty??true) {
                          return 'Por favor ingrese un título';
                        }
                        return null;
                      },
                      onChanged: (value){
                        context.read<AddTodoBloc>().updateTitle(value);
                      },
                    ),
                    TextFormField(
                      maxLines: null,
                      minLines: 3,
                      maxLength: 150,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                        alignLabelWithHint: true,
                      ),
                      onChanged: (value){
                        context.read<AddTodoBloc>().updateDescription(value);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tareas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Column(
                            children: state.tasks?.map((task)=> ListTile(
                              title:  Text(task.name),
                              trailing: IconButton(
                                onPressed: (){
                                  context.read<AddTodoBloc>().deleteTask(task);
                                },
                                icon: const Icon(Icons.close)),
                            )).toList()??[]
                          ),
                          TextButton(onPressed: (){
                            showTaskNameModal(context).then((taskName){
                              if(taskName != null){
                                context.read<AddTodoBloc>().addTask(Task(name: taskName));
                              }
                            });
                          }, child: const Text('+ Agregar tarea')),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){

                if(state.tasks?.isEmpty??true){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor agregue al menos una tarea'),
                      duration: Duration(seconds: 2),
                    )
                  );
                }

                if(_formKey.currentState!.validate() && (state.tasks?.isNotEmpty??false)){
                  context.read<TodoListBloc>().addTodo(state);
                  Navigator.pop(context);
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Center(
                  child: Text(
                    'Agregar', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      )
                    ),
                ),
              ),
            )
          ],
        );
      }
    );
  }
}
