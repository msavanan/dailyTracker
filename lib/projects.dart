import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: Center(
                  child: Column(
            children: [
              Text("Projects"),
              Container(
                color: Colors.grey,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(child: Text("Add Projects")),
              )
            ],
          ))))
    ]);
  }
}
