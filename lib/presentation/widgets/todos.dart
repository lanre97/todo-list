import 'package:flutter/material.dart';

class TodoStick extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const TodoStick({Key? key, this.title="", this.color = Colors.yellow, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          color: color,
          child: Text(
            title, 
            style: TextStyle(
              color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
              fontSize: 20, 
              fontFamily: 'kristen'
              ),
            textAlign: TextAlign.center
            ),
        ),
      ),
    );
  }
}