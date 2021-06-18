import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  final String time;
  bool checktime = true;
  TaskCardWidget({this.title, this.desc, this.time});

  @override
  Widget build(BuildContext context) {
    return   FocusedMenuHolder(
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
                  backgroundColor: Colors.transparent,
                  title: Expanded(
                      child: Text(
                    title,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )),
                  onPressed: () {}),
              FocusedMenuItem(
                  backgroundColor: Colors.transparent,
                  title: Expanded(
                    child: LayoutBuilder(builder: (context, constraints) {
                      print(constraints.maxWidth);
                      return Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: Row(
                          children: [
                            Expanded(
                                child: RaisedButton(
                                    elevation: 0,
                                    color: Colors.red,
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {})),
                            Expanded(
                                child: RaisedButton(
                                    color: Colors.green,
                                    elevation: 0,
                                    child: Text(
                                      "Complete",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {})),
                          ],
                        ),
                      );
                    }),
                  ),
                  onPressed: () {})
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
                      title,
                    ),
                    Text(
                      '2 minutes',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Open",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        
    
  

    // Container(
    //   width: double.infinity,
    //   padding: EdgeInsets.symmetric(
    //     vertical: 32.0,
    //     horizontal: 24.0,
    //   ),
    //   margin: EdgeInsets.only(
    //     bottom: 20.0,
    //   ),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(20.0),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         title ?? "(Unnamed Task)",
    //         style: TextStyle(
    //           color: Color(0xFF211551),
    //           fontSize: 22.0,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(
    //           top: 10.0,
    //         ),
    //         child: Text(
    //           desc ?? "No Description Added",
    //           style: TextStyle(
    //             fontSize: 16.0,
    //             color: Color(0xFF86829D),
    //             height: 1.5,
    //           ),
    //         ),
    //       ),

    //     ],
    //   ),
    // );
  }
}

class TodoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  TodoWidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
                color: isDone ? Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone
                    ? null
                    : Border.all(color: Color(0xFF86829D), width: 1.5)),
            child: Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Text(
              text ?? "(Unnamed Todo)",
              style: TextStyle(
                color: isDone ? Color(0xFF211551) : Color(0xFF86829D),
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
