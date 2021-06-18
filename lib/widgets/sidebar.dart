import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ticktack/screens/completed.dart';
import 'package:ticktack/screens/homepage.dart';
import 'package:ticktack/screens/open.dart';

import '../constants.dart';
import 'drawerheader.dart';
import 'fadepageroute.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: IconTheme(
            data: IconThemeData(
              size: 18,
              color: Colors.black,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 DrawerHeaderWidget(),
                  DrawerMenuGroup(
                    children: [
                      DrawerMenuItem(
                        icon: Feather.list,
                        title: "Projects",
                        to: Homepage(),
                      ),
                      Divider(
                        height: 1,
                      ),
                      DrawerMenuItem(
                        icon: Feather.download,
                        title: "Open",
                        to: Open(),
                      ),
                      Divider(
                        height: 1,
                      ),
                     
                      Divider(
                        height: 1,
                      ),
                      DrawerMenuItem(
                        icon: Feather.check,
                        title: "Completed",
                        to: CompletedProjects(),
                      ),
                      Divider(
                        height: 1,
                      ),
                      DrawerMenuItem(
                        icon: Feather.folder,
                        title: "Permission",
                        to: Homepage(),
                      ),
                      Divider(
                        height: 1,
                      ),
                      DrawerMenuItem(
                        icon: Feather.star,
                        title: "Rate Our App",
                        to: Homepage(),
                      ),
                      Divider(
                        height: 1,
                      ),
                      DrawerMenuItem(
                        icon: Feather.share_2,
                        title: "Share",
                        to: Homepage(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final data;
  final Widget to;

  const DrawerMenuItem(
      { this.icon,  this.title, this.data,  this.to});

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: TextStyle(
        fontFamily: Constants.POPPINS,
      ),
      child: ListTile(
        dense: true,
        onTap: () =>
            Navigator.of(context).push(FadePageRoute(route: (context) => to)),

        
        // ignore: unnecessary_null_comparison
        leading: icon != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Constants.blackcolor,
                  ),
                ],
              )
            : null,
        trailing: data != null && data != "0"
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(data,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              )
            : null,
        // subtitle: subtitle != null ? Text(subtitle) : null,
        title: Text(title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }
}

class DrawerMenuGroup extends StatelessWidget {
  final List<Widget> children;

  const DrawerMenuGroup({this.children = const <Widget>[]});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}
