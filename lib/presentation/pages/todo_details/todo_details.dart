import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/blocs/todo_details_bloc/todo_details_bloc.dart';
import 'package:todo_list/blocs/todo_details_bloc/todo_details_state.dart';
import 'package:todo_list/domain/models/task.dart';
import 'package:todo_list/domain/models/todo.dart';
import 'package:todo_list/domain/repositories/todo_repository.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
    final backgroundColor = Color(todo.color!);
    final textColor = backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return BlocProvider(
      create: (context) => TodoDetailsBloc(
        todoRepository:context.read<TodoRepository>()
        )..init(todo),
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: textColor
        ),
        body: Column(children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 56.0),
          Text(
            todo.title ?? ''
            , style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textColor
            )),
          Text(
            todo.description ?? '',
            style: TextStyle(
              fontSize: 16,
              color: textColor
            )),
          const Expanded(child: TodoTaskList()),
        ],)
      ),
    );
  }
}

class TodoTaskList extends StatelessWidget {
  const TodoTaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDetailsBloc,TodoDetailsState>(
      builder: (context,state){
        if(state is TodoDetailsIsLoading){
          return const Center(child: CircularProgressIndicator());
        }
        if(state is TodoDetailsOnError){
          return const Center(child: Text('Error', style: TextStyle(color: Colors.red)));
        }
        if(state is TodoDetailsIsLoaded){
          return ListView.builder(
            itemCount: state.todo?.tasks?.length ?? 0,
            itemBuilder:(context, index) => TodoTask(
              idTodo:state.todo!.id!, 
              task: state.todo!.tasks![index]
              ),
          );
        }
        return Container();
      }
    );
  }
}

class TodoTask extends StatefulWidget {
  final String idTodo;
  final Task task;
  const TodoTask({
    Key? key, 
    required this.idTodo,
    required this.task
    }) : super(key: key);

  @override
  _TodoTaskState createState() => _TodoTaskState();
}

class _TodoTaskState extends State<TodoTask> {

  late bool _isChecked;

  @override
  void initState() {
    _isChecked = widget.task.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.name, style: TextStyle(decoration: _isChecked?TextDecoration.lineThrough:null),),
      leading: IconButton(
        icon: Icon(_isChecked?Icons.check_box_outlined:Icons.check_box_outline_blank),
        onPressed: () {
          setState(() {
            _isChecked = !_isChecked;
          });
          context.read<TodoDetailsBloc>().updateTaks(
            widget.idTodo, 
            widget.task.copyWith(isDone: _isChecked));
        },
      ),
    );
  }
}