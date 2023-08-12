import 'package:flutter/material.dart';
import 'package:todo_app/screen/buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key,
   required this.controller,
  required this.onSave,
  required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 120,
        child: Column(children: [
          //get user input
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task",
            ),
          ),

          //buttons -> save + cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //save button
              MyButton(text: "Save", onPressed: onSave),
              const SizedBox(
                width: 10,
              ),
              

              //cancel Button
              MyButton(text: "Cancel", onPressed:onCancel)
            ],
          )
        ]),
      ),
    );
  }
}
