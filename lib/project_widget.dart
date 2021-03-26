import 'package:daily_tracker/project_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectWidget extends StatefulWidget {
  final int projectNumber;
  final String projectTitle;
  ProjectWidget({this.projectNumber, this.projectTitle});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  bool textFilled = false;

  @override
  Widget build(BuildContext context) {
    if (widget.projectTitle.isNotEmpty) {
      setState(() {
        textFilled = true;
      });
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project ${widget.projectNumber}"),
          textFilled
              ? Text(Provider.of<ProjectList>(context)
                      .projectList[widget.projectNumber - 1]
                      .title ??
                  "")
              : TextField(
                  //maxLines: 2 ,
                  onSubmitted: (value) {
                    Provider.of<ProjectList>(context, listen: false)
                        .add(number: widget.projectNumber - 1, title: value);
                    print(Provider.of<ProjectList>(context, listen: false)
                        .projectList[widget.projectNumber - 1]
                        .title);
                  },
                  onEditingComplete: () {
                    print("onEditing Complete");
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }

                    setState(() {
                      textFilled = true;
                    });
                  },
                )
        ],
      ),
    );
  }
}
