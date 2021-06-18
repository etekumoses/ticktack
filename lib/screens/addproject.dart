import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticktack/provider/task_data.dart';
import 'package:ticktack/widgets/contactus_textfield_widget.dart';
import 'package:ticktack/widgets/submitbtn.dart';

import '../constants.dart';

class AddProjectView extends StatefulWidget {
  static const String id = 'add_project';
  final bool isupdate;
  final String projecttitle;
  final String projectdesc;
  const AddProjectView(
      {Key key, this.isupdate =true, this.projectdesc, this.projecttitle})
      : super(key: key);
  @override
  _AddProjectViewState createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String title = "";
  String description = "";
  //  final TextEditingController _taskTitleController = TextEditingController();
  // final TextEditingController _taskdescController = TextEditingController();

  bool titleValidate = false;
  bool descValidate = false;
  DateTime _currentTime = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    const Widget _largeSpacingWidget = SizedBox(
      height: 8,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constants.graywhitecolor,
        title: Text(
          widget.isupdate ? "Edit Project" : "Create Project",
          style: TextStyle(
              fontFamily: Constants.POPPINS,
              fontWeight: FontWeight.bold,
              fontSize: 22.5,
              color: Constants.primarycolor),
        ),
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Constants.primarycolor),
        textTheme: Theme.of(context).textTheme,
        brightness: Theme.of(context).brightness,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ContactUsTextWidget(
                  titleText: 'Title',
                  isMandatory: true,
                  hintText: widget.isupdate
                      ? widget.projecttitle
                      : 'Enter project title',
                  onchanged: (value) {
                    title = value;
                  },
                  textEditingController: titleController),
              ContactUsTextWidget(
                  titleText: 'Description',
                  height: 160,
                  isMandatory: true,
                  hintText: widget.isupdate
                      ? widget.projectdesc
                      : 'Type your message here',
                  onchanged: (value) {
                    description = value;
                  },
                  textEditingController: descController),
              Container(
                margin: const EdgeInsets.only(
                    left: 16, top: 16, right: 16, bottom: 40),
                child: ButtonWidget(press: () {
                  setState(() {
                    title.isEmpty
                        ? titleValidate = true
                        : titleValidate = false;
                    description.isEmpty
                        ? descValidate = true
                        : descValidate = false;
                  });
                  if (titleValidate == true && descValidate == true) {
                    return;
                  }
                  widget.isupdate ? update() : save();

                  Navigator.pop(context);
                }),
              ),
              _largeSpacingWidget,
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    Provider.of<TaskData>(context, listen: false)
        .addTask(title, description, _currentTime.toString());
  }

  void update() {
    Provider.of<TaskData>(context, listen: false)
        .updateTask(title, description, _currentTime.toString());
  }
}
