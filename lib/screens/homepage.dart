import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:ticktack/models/task.dart';
import 'package:ticktack/provider/task_data.dart';
import 'package:ticktack/screens/addproject.dart';
import 'package:ticktack/widgets/fadepageroute.dart';
import 'package:ticktack/widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeage;
import 'package:ticktack/widgets/noprojects.dart';
import 'package:ticktack/widgets/sidebar.dart';
import '../constants.dart';

class Homepage extends StatefulWidget {
  static const String id = 'homepage';
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final incompletedtasks = Provider.of<TaskData>(context).inCompleteTasks;
    final completedtasks = Provider.of<TaskData>(context).completedTasks;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Constants.graywhitecolor,
        centerTitle: true,
        title: Text(
          'Project Manager',
          style: TextStyle(
            color: Constants.primarycolor,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.POPPINS,
          ),
        ),
        iconTheme: IconThemeData(color: Constants.primarycolor),
        elevation: 0,
      ),
      drawer: SideBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          color: Color(0xFFF6F6F6),
          child: ListView(
            children: [
              Consumer<TaskData>(builder: (context, taskData, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(7.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8, color: Colors.grey.shade300)
                            ]),
                        height: MediaQuery.of(context).size.height * .15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Feather.list,
                                color: Constants.primarycolor,
                              ),
                              Spacer(),
                              Text(
                                'Open Projects',
                                style: TextStyle(
                                    height: 1.5,
                                    fontFamily: Constants.POPPINS,
                                    color: Constants.blackcolor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                              Text(
                                incompletedtasks.length.toString() +
                                    ' projects',
                                style: TextStyle(
                                    height: 1.5,
                                    fontFamily: Constants.POPPINS,
                                    color: Constants.blackcolor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(7.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8, color: Colors.grey.shade300)
                            ]),
                        height: MediaQuery.of(context).size.height * .15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Feather.check_circle,
                                color: Constants.primarycolor,
                              ),
                              Spacer(),
                              Text(
                                'Completed Projects',
                                style: TextStyle(
                                    height: 1.5,
                                    color: Constants.blackcolor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                              Text(
                                completedtasks.length.toString() + ' projects',
                                style: TextStyle(
                                    height: 1.5,
                                    fontFamily: Constants.POPPINS,
                                    color: Constants.blackcolor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StickyHeader(
                    header: HeaderLabel("Open", Colors.blue),
                    content: OpenList(
                      scaffoldKey: _scaffoldKey,
                    ),
                  ),
                  StickyHeader(
                    header: HeaderLabel("Completed", Colors.green),
                    content: ClipRect(child: CompletedList()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.primarycolor,
          onPressed: () {
            Navigator.of(context).push(FadePageRoute(
              route: (context) => AddProjectView(isupdate: false),
            ));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}

class HeaderLabel extends StatelessWidget {
  final String label;
  final Color color;

  const HeaderLabel(this.label, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: color,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                label,
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            Spacer(),
            CustomPaint(
              size: Size(80, 80 * 0.5),
              painter: HeaderStickyBackground(),
            ),
            Container(
              width: 100,
              color: Colors.white,
              height: 80 * .5,
            )
          ],
        ));
  }
}

class OpenList extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const OpenList({this.scaffoldKey});
  @override
  _OpenListState createState() => _OpenListState();
}

class _OpenListState extends State<OpenList> {
  @override
  Widget build(BuildContext context) {
    final incompletedtasks = Provider.of<TaskData>(context).inCompleteTasks;
    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 7.5, 0, 7.5),
        itemCount: incompletedtasks.length,
        itemBuilder: (context, index) {
          print(incompletedtasks.length);
          if (incompletedtasks.length >= 1) {
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
                            projectdesc: incompletedtasks[index].description,
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
              child: Container(
                margin: EdgeInsets.all(7.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 8, color: Colors.grey.shade300)
                    ]),
                child: ListTile(
                  leading: Icon(Feather.target),
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        incompletedtasks[index].title,
                      ),
                      Text(
                        timeage.format(
                            DateTime.parse(incompletedtasks[index].time)),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Open",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return NonProjectsScreen();
          }
        },
      ),
    );
  }
}

class CompletedList extends StatelessWidget {
  final DateTime _currentTime = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    final completedtasks = Provider.of<TaskData>(context).completedTasks;
    return Consumer<TaskData>(builder: (context, taskData, child) {
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
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 8, color: Colors.grey.shade300)
                    ]),
                child: ListTile(
                  leading: Icon(Feather.check_circle),
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(completedtasks[index].title),
                      Text(
                        timeage.format(_currentTime),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class HeaderStickyBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2500000, 0);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.2500000, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// class InCompleteList extends StatefulWidget {
//   const InCompleteList({ Key key }) : super(key: key);

//   @override
//   _InCompleteListState createState() => _InCompleteListState();
// }

// class _InCompleteListState extends State<InCompleteList> {

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TaskData>(builder: (context, taskData, child) {
//       return ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return FocusedMenuHolder(
//             blurSize: 5.0,
//             menuBoxDecoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(8))),
//             // duration: 100.,
//             menuWidth: MediaQuery.of(context).size.shortestSide - 30,
//             animateMenuItems: false,
//             menuItemExtent: 50,
//             onPressed: () {},
//             menuItems: [
//               FocusedMenuItem(
//                   backgroundColor: Colors.transparent,
//                   title: Expanded(
//                       child: Text(
//                     'title',
//                     maxLines: 3,
//                     style: TextStyle(
//                       fontSize: 12,
//                     ),
//                   )),
//                   onPressed: () {}),
//               FocusedMenuItem(
//                   trailingIcon: Icon(Feather.truck),
//                   title: Text("Mark as complete"),
//                   onPressed: () {}),
//             ],
//             openWithTap: true,
//             child: Container(
//               margin: EdgeInsets.symmetric(vertical: 7.5),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(blurRadius: 8, color: Colors.grey.shade300)
//                   ]),
//               child: ListTile(
//                 leading: Icon(Feather.shopping_bag),
//                 dense: true,
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('title'),
//                     Text(
//                       '3 minutes',
//                       style: TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 subtitle: Text(
//                   "onProcess",
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
