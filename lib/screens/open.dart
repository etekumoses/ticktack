import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:ticktack/provider/task_data.dart';
import 'package:ticktack/widgets/fadepageroute.dart';
import 'package:ticktack/widgets/noprojects.dart';
import 'package:ticktack/widgets/widgets.dart';

import 'package:timeago/timeago.dart' as timeage;
import '../constants.dart';
import 'addproject.dart';

class Open extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Open({this.scaffoldKey});

  @override
  _OpenState createState() => _OpenState();
}

class _OpenState extends State<Open> {
  @override
  Widget build(BuildContext context) {
    final incompletedtasks = Provider.of<TaskData>(context).inCompleteTasks;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Constants.graywhitecolor,
        title: Text(
          "Open Projects",
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
      backgroundColor: Constants.graywhitecolor,
      body: ScrollConfiguration(
        
        behavior: NoGlowBehaviour(),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
          itemCount: incompletedtasks.length,
          itemBuilder: (context, index) {
            if (incompletedtasks.length != 0) {
              return FocusedMenuHolder(
                  blurSize: 5.0,
                  menuBoxDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  // duration: 10,
                  menuWidth: MediaQuery.of(context).size.shortestSide - 15,
                  animateMenuItems: true,
                  openWithTap: true,
                  menuItemExtent: 50,
                  onPressed: () {},
                  menuItems: [
                    FocusedMenuItem(
                        trailingIcon: Icon(Feather.edit),
                        title: Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(FadePageRoute(
                            route: (context) => AddProjectView(
                                isupdate: true,
                                projectdesc:
                                    incompletedtasks[index].description,
                                projecttitle: incompletedtasks[index].title),
                          ));
                        }),
                    FocusedMenuItem(
                        trailingIcon: Icon(Feather.check_circle),
                        title: Text(
                          "Mark as Completed",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<TaskData>(context, listen: false)
                              .toggleTask(incompletedtasks[index]);
                        }),
                    FocusedMenuItem(
                        trailingIcon: Icon(
                          Feather.trash_2,
                          color: Colors.red,
                        ),
                        title: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<TaskData>(context, listen: false)
                              .deleteTask(incompletedtasks[index].id);
                        }),
                  ],
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
                            incompletedtasks[index].title,
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
                            incompletedtasks[index].description,
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
            } else {
              return NonProjectsScreen();
            }
          },
        ),
      ),
    );
  }
}
