import 'package:flutter/material.dart';

class ProjectTracker extends ChangeNotifier {
  String date;
  String cProjectTitle;
  String cProjectUpdate;

  String nProjectTitle;
  String nProjectUpdate;

  int currentIndex = 0;

  List<IssueTracker> issueTrackerList = [];
}

class IssueTracker {
  String sno;
  String issue;
  String status;
}
