import 'package:daily_tracker/cell.dart';
import 'package:daily_tracker/createXL.dart';
import 'package:daily_tracker/date_picker.dart';
import 'package:daily_tracker/editable_cell.dart';
import 'package:daily_tracker/gestureState.dart';
import 'package:daily_tracker/project/project_list.dart';
import 'package:daily_tracker/row_cell.dart';
import 'package:daily_tracker/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'createXL.dart';

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
        )
      ],
      child: MaterialApp(
          title: 'Daily Tracker',
          //theme: ThemeData(primarySwatch: Colors.blue,),
          home: TrackerSheet()), //MyHomePage(title: 'Daily Tracker'),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Daily Updating Tracker_(Name)"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Date: 18 MAR 2021"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Project"), TextField()],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Update"), TextField()],
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: Text("Create Task")),
              ],
            ),
          ),
        ));
  }
}*/

class TrackerSheet extends StatefulWidget {
  @override
  _TrackerSheetState createState() => _TrackerSheetState();
}

class _TrackerSheetState extends State<TrackerSheet> {
  bool update = false;
  bool project = false;

  @override
  Widget build(BuildContext context) {
    createXL();
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
                                  )),
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
                                    /*GestureDetector(
                                      child: Icon(Icons.add),
                                      onTap: () {
                                        print('Add row');
                                      },
                                    ),*/
                                    Expanded(
                                      child: Cell(
                                        txt: 'Issue',
                                      ),
                                    ),
                                    /*GestureDetector(
                                      child: Icon(Icons.remove),
                                      onTap: () {
                                        print('Delete row');
                                      },
                                    ),*/
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
                        RowCell(),
                        RowCell(),
                        RowCell(),
                        RowCell(),
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
                                  )), //Cell(txt: '', ),
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
                                  )),
                            ), //Cell(txt: '', ),
                          ],
                        ),
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
