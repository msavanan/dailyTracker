import 'package:daily_tracker/project_management/project.dart';
import 'package:flutter/material.dart';

class ProjectList extends ChangeNotifier {
  List<Project> projectList = [];
  String title;

  add({@required int number, @required String title}) {
    projectList.add(
      Project(number: projectList.length + 1, title: title),
    );
    notifyListeners();
  }
}
