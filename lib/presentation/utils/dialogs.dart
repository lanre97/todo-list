import 'package:flutter/material.dart';
import 'package:todo_list/presentation/widgets/dialogs/color_picker.dart';
import 'package:todo_list/presentation/widgets/dialogs/task_name_modal.dart';

showColorPicker(BuildContext context)async{
  return await showDialog<Color>(
    context: context, 
    builder: (context)=> ColorPicker(
      onColorChanged: (color){
        Navigator.of(context).pop(color);
      })
    );
}

showTaskNameModal(BuildContext context)async{
  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
    builder: (context)=> TaskNameModal(onSubmit: (name){
      Navigator.of(context).pop(name);
    })
  );
}

showYesNoDialog(BuildContext context, {String? title, String? content})async{
  return await showDialog<bool>(
    context: context,
    builder: (context)=> AlertDialog(
      title: title != null ? Text(title) : null,
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        TextButton(
          child: const Text('Yes'),
          onPressed: (){
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: (){
            Navigator.of(context).pop(false);
          },
        )
      ],
    )
  );
}