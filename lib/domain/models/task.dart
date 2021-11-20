class Task{
  final String? id;
  final String name;
  final bool isDone;

  const Task({required this.name, this.id, this.isDone = false});

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'isDone': isDone
    };
  }

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json['id'] as String,
      name: json['name'] as String,
      isDone: json['isDone'] as bool
    );
  }

  Task copyWith({ String? id, String? name, bool? isDone }){
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isDone: isDone ?? this.isDone
    );
  }

}