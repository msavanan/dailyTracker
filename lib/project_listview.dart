import 'package:daily_tracker/project_list.dart';
import 'package:daily_tracker/project_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectListView extends StatefulWidget {
  @override
  _ProjectListViewState createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  List<ProjectWidget> projectWidgetList = [];

  checkProject() {
    var projectList = Provider.of<ProjectList>(context).projectList;
    if (projectWidgetList.isEmpty) {
      if (projectList.isNotEmpty) {
        for (int i = 0; i < projectList.length; i++) {
          projectWidgetList.add(ProjectWidget(
            projectNumber: projectList[i].number,
            projectTitle: projectList[i].title,
          ));
        }
      }
    }
  }

  createProject() {
    setState(() {
      projectWidgetList.add(ProjectWidget(
        projectNumber: projectWidgetList.length + 1,
        projectTitle: '',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    checkProject();
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Text("Projects"),
        ),
        body: ListView.builder(
            itemCount: projectWidgetList.length,
            itemBuilder: (context, i) {
              return projectWidgetList[i];
            }),
        // Future version
        /* Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white60,
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*Text("Add Projects"),*/ TextButton(
                        onPressed: () {}, child: Icon(Icons.add))
                  ],
                )),
              )
            ],
          ),
        ),*/
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            createProject();

            print("Floating action button");
          },
        ),
      )
    ]);
  }
}
