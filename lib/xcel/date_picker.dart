import 'package:daily_tracker/database/db2Table.dart';
import 'package:daily_tracker/database/db_daily_tracker.dart';
import 'package:daily_tracker/xcel/cell.dart';
import 'package:daily_tracker/project/project_tracker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime _fromDate = DateTime.now();
TimeOfDay _fromTime = TimeOfDay.fromDateTime(DateTime.now());
DateTimeRange _fromRange =
    DateTimeRange(start: DateTime.now(), end: DateTime.now());

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  bool widget2Text = false;

  Future<void> _showDateRangePicker(BuildContext context) async {
    final picked = await showDateRangePicker(
      useRootNavigator: false,
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      setState(() {
        _fromRange = picked;
      });
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _fromTime,
    );
    if (picked != null && picked != _fromTime) {
      setState(() {
        _fromTime = picked;
      });
    }
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null /*&& picked != _fromDate*/) {
      setState(() {
        _fromDate = picked;
      });
      //Project Tracker class
      String date = '${DateFormat.yMMMd().format(_fromDate)}';

      Provider.of<ProjectTracker>(context, listen: false).date = date;

      print("call from Date Picker");
      print("Date;${Provider.of<ProjectTracker>(context, listen: false).date}");

      bool cond = await DailyTrackerDatabase.instance
          .searchQuery("currentProject", date);
      print('Call from date picker line number: 65');
      print(cond);
      if (cond) {
        await Provider.of<DB2Table>(context, listen: false)
            .checkCurrentDate(context, date);
      } else {
        Provider.of<ProjectTracker>(context, listen: false).setTable(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
            onTap: () {
              _showDatePicker(context);
            },
            child: Cell(txt: '${DateFormat.yMMMd().format(_fromDate)}')),
      ),
    );
  }
}
