import 'package:flutter/cupertino.dart';

class Constants{
  // colors
  static const Color primarycolor =Color(0xFFD54621);
  static const Color whitecolor =Color(0xFFFFFFFF);
  static const Color graywhitecolor =Color(0xFFF6F6F6);
  static const Color graycolor =Color(0xFFA9A9A9);
  static const Color blackcolor =Color(0xFF000000);

   // font family
  static const String POPPINS = "Poppins";
  // timeago
  static String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hr(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} min(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} sec(s) ago';
    } else {
      return 'just now';
    }
  }
}