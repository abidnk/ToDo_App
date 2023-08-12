import 'package:flutter/material.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text(
            "TO DO",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
        
  );
  }
}
