import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ticktack/constants.dart';

class NonProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            MaterialCommunityIcons.emoticon_cry_outline,
            color: Colors.grey.shade300,
            size: 80,
          ),
          Text(
            "No Open Progects Available",
            style: TextStyle(fontWeight: FontWeight.w600,color: Constants.graycolor,fontFamily: Constants.POPPINS),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
