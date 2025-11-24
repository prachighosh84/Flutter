import 'package:flutter/material.dart';

class FirstContent extends StatelessWidget {
  const FirstContent({super.key});

  void _onButtonPressed(){
    Text("button pressed");
  }
  @override
  Widget build(BuildContext context) {
    return Center(

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          Text("First Content"),
          ElevatedButton(
            onPressed: _onButtonPressed,
            child: Text("Click Me"),
          ),
        ]
      )
    );
  }


}
