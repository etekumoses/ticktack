import 'package:flutter/material.dart';

import '../constants.dart';

class DrawerHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
           CircleAvatar(
                      radius: 40,
                      backgroundColor: Constants.whitecolor,
                      child:
                          Image(image: AssetImage('assets/images/logo.png'))),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Project Manager',
            style: TextStyle(
              color: Constants.primarycolor,
              fontWeight: FontWeight.bold,
              fontFamily: Constants.POPPINS,
              fontSize: 20
            ),
          ),
        ],
      ),
       );
  }
}
