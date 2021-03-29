import 'package:flutter/material.dart';

class ProjectTracker extends ChangeNotifier {
  String date;
  String cProjectTitle;
  String cProjectUpdate;

  String nProjectTitle;
  String nProjectUpdate;

  List<IssueTracker> issueTrackerList = [];
}

class IssueTracker {
  int sno;
  String issue;
  String status;
}
