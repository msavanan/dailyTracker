import 'package:daily_tracker/database/db_daily_tracker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectTracker extends ChangeNotifier {
  String date = '${DateFormat.yMMMd().format(DateTime.now())}';
  String cProjectTitle = '';
  String cProjectUpdate = '';

  String nProjectTitle = '';
  String nProjectUpdate = '';

  int activeRow = 0;

  int currentIndex = 0;

  List<IssueTracker> issueTrackerList = [];

  addIssue() {
    issueTrackerList.add(IssueTracker(sno: '', issue: '', status: '', id: 0));
    currentIndex++;
    notifyListeners();
  }

  removeIssue() {
    issueTrackerList.removeLast();
    currentIndex--;
    notifyListeners();
  }

  setTable(BuildContext context) {
    this.date = '${DateFormat.yMMMd().format(DateTime.now())}';
    this.cProjectTitle = '';
    this.cProjectUpdate = '';

    this.nProjectTitle = '';
    this.nProjectUpdate = '';

    this.currentIndex = 0;

    this.issueTrackerList = [];
    this.addIssue();

    notifyListeners();
  }

  updateTable(BuildContext context, date) async {
    print('Call from ProjectTracker - updateTable function - line number 40');
    var tb = await DailyTrackerDatabase.instance
        .selectByDate('currentProject', date);
    var tb1 =
        await DailyTrackerDatabase.instance.selectByDate('projection', date);
    var tb2 = await DailyTrackerDatabase.instance.selectByDate('issue', date);
    print('ProjectTracker line 64');
    print('$tb');
    print('$tb1');
    print('$tb2');

    this.date = tb[0]['date'];
    this.cProjectTitle = tb[0]['projectTitle'];

    this.cProjectUpdate = tb[0]['projectUpdate'];

    this.nProjectTitle = tb1[0]['projectTitle'];
    this.nProjectUpdate = tb1[0]['projectUpdate'];

    print('Call from ProjectTracker line number 81');
    print(this.issueTrackerList.length);

    this.issueTrackerList = [];

    for (int i = 0; i < tb2.length; i++) {
      this.currentIndex = i;
      this.issueTrackerList.add(IssueTracker());

      this.issueTrackerList[i].sno = tb2[i]['slno'].toString();
      this.issueTrackerList[i].issue = tb2[i]['issue'];
      this.issueTrackerList[i].status = tb2[i]['status'];
      this.issueTrackerList[i].id = i;
    }
    notifyListeners();
  }
}

class IssueTracker {
  IssueTracker(
      {String sno = '', String issue = '', String status = '', int id = 0});
  String sno;
  String issue;
  String status;
  int id;
}
