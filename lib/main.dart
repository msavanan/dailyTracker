import 'package:daily_tracker/database/db2Table.dart';
import 'package:daily_tracker/database/table2db.dart';
import 'package:daily_tracker/xcel/cell.dart';
import 'package:daily_tracker/xcel/date_picker.dart';
import 'package:daily_tracker/xcel/editable_cell.dart';
import 'package:daily_tracker/gestureState.dart';
import 'package:daily_tracker/project_management/project_list.dart';
import 'package:daily_tracker/project/project_tracker.dart';
import 'package:daily_tracker/xcel/issue_tracker_widgets.dart';
import 'package:daily_tracker/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DailyTracker());
}

class DailyTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GestureState>(
            create: (context) => GestureState()),
        ChangeNotifierProvider<ProjectList>(
          create: (context) => ProjectList(),
        ),
        ChangeNotifierProvider<ProjectTracker>(
            create: (context) => ProjectTracker()),
        ChangeNotifierProvider<DB2Table>(
            create: (context) => DB2Table(
                currentTable:
                    Provider.of<ProjectTracker>(context, listen: false))),
      ],
      child: MaterialApp(
        title: 'Daily Tracker',
        home: TrackerSheet(),
      ),
    );
  }
}

class TrackerSheet extends StatefulWidget {
  @override
  _TrackerSheetState createState() => _TrackerSheetState();
}

class _TrackerSheetState extends State<TrackerSheet> {
  bool update = false;
  bool project = false;

  @override
  void initState() {
    super.initState();
    initializeDate();
  }

  initializeDate() async {
    await Provider.of<DB2Table>(context, listen: false).checkCurrentDate(
        context, '${DateFormat.yMMMd().format(DateTime.now())}');
  }

  @override
  Widget build(BuildContext context) {
    ProjectTracker projectTracker =
        Provider.of<ProjectTracker>(context, listen: false);

    return Consumer<GestureState>(
      builder: (context, gestureState, child) => GestureDetector(
        onPanUpdate: (panValue) {
          double sensitivity = 4;
          if (panValue.delta.dx > sensitivity /*0*/) {
            print("Swipe Right");
            gestureState.updateSwipe();
          } else if (panValue.delta.dx < -sensitivity /*0*/) {
            print("Swipe Left");
            gestureState.updateSwipe();
          }
        },
        child: Stack(
          children: [
            Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          //color: Colors.blueAccent,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Center(
                              child:
                                  Text("Daily Updating Tracker - M Saravanan")),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Cell(
                                txt: 'Date',
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: DatePicker(),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Cell(
                                txt: 'Project',
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                  onTap: () {},
                                  child: EditableCell(
                                    onChanged: (value) {
                                      projectTracker.cProjectTitle = value;
                                    },
                                    initialText: Provider.of<ProjectTracker>(
                                                context,
                                                listen: true)
                                            .cProjectTitle ??
                                        '',
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Cell(
                                txt: 'Update',
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {},
                                child: EditableCell(
                                  onChanged: (value) {
                                    projectTracker.cProjectUpdate = value;
                                  },
                                  initialText: Provider.of<ProjectTracker>(
                                              context,
                                              listen: true)
                                          .cProjectUpdate ??
                                      '',
                                ),
                              ),
                            )
                          ],
                        ),
                        IssueTrackerWidget(),
                        Cell(txt: 'Project For Next Working Day'),
                        Row(
                          children: [
                            Expanded(
                              child: Cell(
                                txt: 'Project',
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {},
                                child: EditableCell(
                                  onChanged: (value) {
                                    projectTracker.nProjectTitle = value;
                                  },
                                  initialText: Provider.of<ProjectTracker>(
                                              context,
                                              listen: true)
                                          .nProjectTitle ??
                                      '',
                                ),
                              ),
                              //Cell(txt: '', ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Cell(
                                txt: 'Update',
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: GestureDetector(
                                  onTap: () {},
                                  child: EditableCell(
                                    onChanged: (value) {
                                      projectTracker.nProjectUpdate = value;
                                    },
                                    initialText: Provider.of<ProjectTracker>(
                                                context,
                                                listen: true)
                                            .nProjectUpdate ??
                                        '',
                                  )),
                            ), //Cell(txt: '', ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Table2db().updateDB(context);
                            },
                            child: Text('Submit'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Provider.of<GestureState>(context, listen: true).swipeRight
                ? SideBar()
                : Container()
          ],
        ),
      ),
    );
  }
}
