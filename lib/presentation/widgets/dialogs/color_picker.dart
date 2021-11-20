import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatefulWidget {
  final Function(Color)? onColorChanged;
  const ColorPicker({Key? key, this.onColorChanged}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color _color = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Elige un color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: _color,
          onColorChanged: (color){
            setState(() {
              _color = color;
            });
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
            widget.onColorChanged?.call(_color);
          },
        ),
      ],
    );
  }
}