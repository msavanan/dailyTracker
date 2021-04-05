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

  int issueTrackerLength = 0;

  List<IssueTracker> issueTrackerList = [];

  setActiveRow(int index) {
    print('Call from project Tracker line number 20 : $index');
    this.activeRow = index;
    notifyListeners();
  }

  addIssue() {
    //Todo add a new rowcell in between cells
    // Todo SlNo should be updated when a rowcell gets deleted
    // Todo when rows added or deleted the created cell or the cell before the deleted cell should be active
    // Todo sqlite database should get updated if the data is getting changed from database addIssue/removeIssue

    issueTrackerList.add(IssueTracker(sno: '', issue: '', status: ''));
    issueTrackerLength++;
    /*this.activeRow = issueTrackerLength;
    print('call from project tracker - activeRow : ${this.activeRow}');*/
    notifyListeners();
  }

  removeIssue(int index) {
    print('call from Project Tracker - Remove Issue : $index');
    issueTrackerList.removeAt(index);
    this.issueTrackerLength = issueTrackerList.length;
    this.activeRow = issueTrackerLength - 1;
    print('call from project tracker ${this.issueTrackerList}');
    notifyListeners();
  }

  setTable(BuildContext context) {
    this.date = '${DateFormat.yMMMd().format(DateTime.now())}';
    this.cProjectTitle = '';
    this.cProjectUpdate = '';

    this.nProjectTitle = '';
    this.nProjectUpdate = '';

    this.issueTrackerLength = 0;

    this.issueTrackerList = [];
    this.addIssue();

    notifyListeners();
  }

  updateTable(BuildContext context, date) async {
    print('Call from ProjectTracker - updateTable function ');
    var tb = await DailyTrackerDatabase.instance
        .selectByDate('currentProject', date);
    var tb1 =
        await DailyTrackerDatabase.instance.selectByDate('projection', date);
    var tb2 = await DailyTrackerDatabase.instance.selectByDate('issue', date);
    print('call from ProjectTracker $tb, $tb1, $tb2');
    print('$tb');
    print('$tb1');
    print('$tb2');

    this.date = tb[0]['date'];
    this.cProjectTitle = tb[0]['projectTitle'];

    this.cProjectUpdate = tb[0]['projectUpdate'];

    this.nProjectTitle = tb1[0]['projectTitle'];
    this.nProjectUpdate = tb1[0]['projectUpdate'];

    print(
        'Call from ProjectTracker this.issueTrackerList.length : ${this.issueTrackerList.length}');

    this.issueTrackerList = [];

    for (int i = 0; i < tb2.length; i++) {
      this.issueTrackerLength = i;
      this.issueTrackerList.add(IssueTracker());

      this.issueTrackerList[i].sno = tb2[i]['slno'].toString();
      this.issueTrackerList[i].issue = tb2[i]['issue'];
      this.issueTrackerList[i].status = tb2[i]['status'];
    }
    this.activeRow = 0;
    notifyListeners();
  }
}

class IssueTracker {
  IssueTracker({
    String sno = '',
    String issue = '',
    String status = '',
  });
  String sno;
  String issue;
  String status;
}
