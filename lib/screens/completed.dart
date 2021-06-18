import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:ticktack/provider/task_data.dart';
import 'package:ticktack/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeage;
import '../constants.dart';

class CompletedProjects extends StatefulWidget {
  const CompletedProjects({ Key key }) : super(key: key);

  @override
  _CompletedProjectsState createState() => _CompletedProjectsState();
}

class _CompletedProjectsState extends State<CompletedProjects> {
  final DateTime _currentTime = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    final completedtasks = Provider.of<TaskData>(context).completedTasks;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constants.graywhitecolor,
        title: Text(
           "Completed Projects",
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
          body: Consumer<TaskData>(builder: (context, taskData, child) {
        return ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
            itemCount: completedtasks.length,
            itemBuilder: (context, index) {
              return FocusedMenuHolder(
                blurSize: 5.0,
                menuBoxDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                menuWidth: MediaQuery.of(context).size.shortestSide - 30,
                animateMenuItems: false,
                menuItemExtent: 50,
                onPressed: () {},
                menuItems: [
                  FocusedMenuItem(
                      trailingIcon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      title: Text("Delete"),
                      onPressed: () {
                        Provider.of<TaskData>(context, listen: false)
                            .deleteTask(completedtasks[index].id);
                      }),
                ],
                openWithTap: true,
                child: Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                          color: Constants.whitecolor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            completedtasks[index].title,
                            style: TextStyle(
                                color: Constants.blackcolor,
                                fontFamily: Constants.POPPINS,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            completedtasks[index].description,
                            style: TextStyle(
                                height: 1.5,
                                color: Constants.blackcolor,
                                fontWeight: FontWeight.w100,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
              );
            },
          ),
        );
      }),
    );
  }
}