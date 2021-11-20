import 'package:flutter/material.dart';

class TaskNameModal extends StatefulWidget {
  final Function(String taskName) onSubmit;
  const TaskNameModal({ Key? key, required this.onSubmit }) : super(key: key);

  @override
  _TaskNameModalState createState() => _TaskNameModalState();
}

class _TaskNameModalState extends State<TaskNameModal> {

  String task = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre de la tarea',
              ),
              onChanged: (value) => setState(() => task = value),
              validator: (value) {
                if (value?.isEmpty??true) {
                  return 'Por favor ingrese el nombre de la tarea';
                }
                return null;
              }
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(child: const Text("Cancelar"),onPressed: (){
                    Navigator.of(context).pop();
                  },),
                  TextButton(child: const Text("Agregar"),onPressed: (){
                    if(_formKey.currentState?.validate()??false){
                      widget.onSubmit(task);
                    }
                  },),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}