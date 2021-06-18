import 'package:flutter/material.dart';

import '../constants.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({
  
     this.icon,
     this.title,
     this.onTap,
  });

  final IconData icon;
  final String title;
  final Function onTap;

  @override
  DrawerMenuWidgetState createState() => DrawerMenuWidgetState();
}

class DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(widget.icon, color: Constants.primarycolor),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onTap: () {
          widget.onTap();
        });
  }
}
