import 'package:daily_tracker/gestureState.dart';
import 'package:daily_tracker/project/project_listview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GestureState>(
      builder: (context, gestureState, child) => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.3,
        margin: EdgeInsets.only(top: 30),
        child: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                child: Icon(Icons.home),
                onTap: () {
                  print("This is home icon");
                  gestureState.updateSwipe();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ProjectListView();
                  }));
                },
              ),
              /*GestureDetector(
                child: Icon(Icons.update),
                onTap: () {
                  print("This is home icon");
                  gestureState.updateSwipe();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ProjectListView();
                  }));
                },
              ) */
            ],
          ),
        ),
      ),
    );
  }
}
