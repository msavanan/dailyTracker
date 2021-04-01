import 'package:daily_tracker/database/db2Table.dart';
import 'package:daily_tracker/database/table2db.dart';
import 'package:daily_tracker/xcel/cell.dart';
//import 'package:daily_tracker/createXL.dart';
import 'package:daily_tracker/xcel/date_picker.dart';
import 'package:daily_tracker/xcel/editable_cell.dart';
import 'package:daily_tracker/gestureState.dart';
import 'package:daily_tracker/project/project_list.dart';
import 'package:daily_tracker/project/project_tracker.dart';
import 'package:daily_tracker/xcel/row_cell.dart';
import 'package:daily_tracker/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //runApp(MyApp());
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
            create: (context) => DB2Table(currentTable: ProjectTracker())),
      ],
      child: MaterialApp(
          title: 'Daily Tracker',
          //theme: ThemeData(primarySwatch: Colors.blue,),
          home: TrackerSheet()), //MyHomePage(title: 'Daily Tracker'),
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

  List<Widget> childWidgets = [];

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
    //createXL();

    /*RowCell(
        snoText: Provider.of<DB2Table>(context, listen: true)
                    .currentTable
                    .issueTrackerList
                    .length !=
                0
            ? Provider.of<DB2Table>(context, listen: true)
                .currentTable
                .issueTrackerList[0]
                .sno
                .toString()
            : '',
        issueText: Provider.of<DB2Table>(context, listen: true)
                    .currentTable
                    .issueTrackerList
                    .length !=
                0
            ? Provider.of<DB2Table>(context, listen: true)
                .currentTable
                .issueTrackerList[0]
                .issue
            : '',
        statusText: Provider.of<DB2Table>(context, listen: true)
                    .currentTable
                    .issueTrackerList
                    .length !=
                0
            ? Provider.of<DB2Table>(context, listen: true)
                .currentTable
                .issueTrackerList[0]
                .status
            : '',
      ),*/

    int length =
        Provider.of<DB2Table>(context, listen: true).currentTable.currentIndex;

    if (childWidgets.length == 0 && length == 0) {
      childWidgets.add(RowCell(
        snoText: '',
        issueText: '',
        statusText: '',
      ));
    } else if (length > 0) {
      childWidgets = [];
      for (int i = 0; i <= length; i++) {
        childWidgets.add(RowCell(
          snoText: Provider.of<DB2Table>(context, listen: false)
              .currentTable
              .issueTrackerList[i]
              .sno,
          issueText: Provider.of<DB2Table>(context, listen: false)
              .currentTable
              .issueTrackerList[i]
              .issue,
          statusText: Provider.of<DB2Table>(context, listen: false)
              .currentTable
              .issueTrackerList[i]
              .status,
        ));
      }
    }

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
              //resizeToAvoidBottomInset: false, //new line
              //appBar: AppBar(),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                  onTap: () {
                                    setState(() {
                                      project = true;
                                    });
                                  },
                                  child: EditableCell(
                                    editable: project,
                                    onChanged: (value) {
                                      Provider.of<ProjectTracker>(context,
                                              listen: false)
                                          .cProjectTitle = value;
                                    },
                                    initialText: Provider.of<DB2Table>(context,
                                                listen: true)
                                            .currentTable
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
                                onTap: () {
                                  setState(() {
                                    update = true;
                                  });
                                },
                                child: EditableCell(
                                  editable: update,
                                  onChanged: (value) {
                                    Provider.of<ProjectTracker>(context,
                                            listen: false)
                                        .cProjectUpdate = value;
                                  },
                                  initialText: Provider.of<DB2Table>(context,
                                              listen: true)
                                          .currentTable
                                          .cProjectUpdate ??
                                      '',
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Cell(
                                txt: 'SL No',
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                          height: 50,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Icon(Icons.add)),
                                      onTap: () {
                                        print('Add row');

                                        int currentIndex =
                                            Provider.of<ProjectTracker>(context,
                                                    listen: false)
                                                .currentIndex;
                                        Provider.of<ProjectTracker>(context,
                                                listen: false)
                                            .currentIndex = currentIndex + 1;
                                        setState(() {
                                          childWidgets.add(RowCell(
                                            snoText: '',
                                            issueText: '',
                                            statusText: '',
                                          ));
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: Cell(
                                        txt: 'Issue',
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: GestureDetector(
                                        child: Icon(Icons.remove),
                                        onTap: () {
                                          print('Delete row');
                                          int currentIndex =
                                              Provider.of<ProjectTracker>(
                                                      context,
                                                      listen: false)
                                                  .currentIndex;
                                          if (currentIndex != 0) {
                                            Provider.of<ProjectTracker>(context,
                                                        listen: false)
                                                    .currentIndex =
                                                currentIndex - 1;
                                          }

                                          setState(() {
                                            int index = childWidgets.length - 1;
                                            childWidgets.removeAt(index);
                                            print('From main at line 271');
                                            print(childWidgets.length);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Cell(
                                txt: 'Status',
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: childWidgets,
                        ),
                        /*RowCell(
                          snoText: Provider.of<DB2Table>(context, listen: true)
                                      .currentTable
                                      .issueTrackerList
                                      .length !=
                                  0
                              ? Provider.of<DB2Table>(context, listen: true)
                                  .currentTable
                                  .issueTrackerList[0]
                                  .sno
                                  .toString()
                              : '',
                          issueText:
                              Provider.of<DB2Table>(context, listen: true)
                                          .currentTable
                                          .issueTrackerList
                                          .length !=
                                      0
                                  ? Provider.of<DB2Table>(context, listen: true)
                                      .currentTable
                                      .issueTrackerList[0]
                                      .issue
                                  : '',
                          statusText:
                              Provider.of<DB2Table>(context, listen: true)
                                          .currentTable
                                          .issueTrackerList
                                          .length !=
                                      0
                                  ? Provider.of<DB2Table>(context, listen: true)
                                      .currentTable
                                      .issueTrackerList[0]
                                      .status
                                  : '',
                        ), */
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
                                onTap: () {
                                  setState(() {
                                    update = true;
                                  });
                                },
                                child: EditableCell(
                                  editable: update,
                                  onChanged: (value) {
                                    Provider.of<ProjectTracker>(context,
                                            listen: false)
                                        .nProjectTitle = value;
                                  },
                                  initialText: Provider.of<DB2Table>(context,
                                              listen: true)
                                          .currentTable
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
                                  onTap: () {
                                    setState(() {
                                      update = true;
                                    });
                                  },
                                  child: EditableCell(
                                    editable: update,
                                    onChanged: (value) {
                                      Provider.of<ProjectTracker>(context,
                                              listen: false)
                                          .nProjectUpdate = value;
                                    },
                                    initialText: Provider.of<DB2Table>(context,
                                                listen: true)
                                            .currentTable
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
