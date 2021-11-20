import 'task.dart';

class Todo{
  final String? id;
  final String? title;
  final String? description;
  final int? color;
  final List<Task>? tasks;

  bool get isDone => tasks?.every((task) => task.isDone) ?? false;

  const Todo({
    this.title,
    this.color,
    this.id,
    this.description,
    this.tasks,
  });

  Map<String,dynamic> toJson() => {
    'title': title,
    'color':color,
    'description': description
  };

  factory Todo.fromJson(Map<String,dynamic> json) => Todo(
    id: json['id'] as String?,
    title: json['title'] as String,
    color: json['color'] as int,
    description: json['description'] as String?,
  );

  Todo copyWith({
    String? id,
    String? title,
    int? color,
    String? description,
    List<Task>? tasks,
  }) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    color: color ?? this.color,
    description: description ?? this.description,
    tasks: tasks ?? this.tasks,
  );

}