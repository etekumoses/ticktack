import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class ContactUsTextWidget extends StatelessWidget {
  final Function onchanged;
  const ContactUsTextWidget(
      {this.textEditingController,
      this.titleText = '',
      this.hintText,
      this.details = false,
      this.height = 44,
      this.showTitle = true,
      this.enabled = true,
      this.onchanged,
      this.keyboardType = TextInputType.text,
      this.isMandatory = false});

  final TextEditingController textEditingController;
  final String titleText;
  final String hintText;
  final double height;
  final bool details;
  final TextInputType keyboardType;
  final bool showTitle;
  final bool isMandatory;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final Widget _productTextWidget =
        Text(titleText, style: Theme.of(context).textTheme.bodyText1);

    return Column(
      children: <Widget>[
        if (showTitle)
          Container(
            margin: const EdgeInsets.only(left: 12, top: 12, right: 12),
            child: Row(
              children: <Widget>[
                if (isMandatory)
                  Row(
                    children: <Widget>[
                      Text(titleText,
                          style: TextStyle(
                            color: Constants.primarycolor,
                            fontSize: width * .03,
                            fontFamily: Constants.POPPINS,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(' *',
                          style: TextStyle(
                            color: Constants.primarycolor,
                            fontSize: width * .03,
                            fontFamily: Constants.POPPINS,
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  )
                else
                  _productTextWidget
              ],
            ),
          )
        else
          Container(
            height: 0,
          ),
        Container(
            width: double.infinity,
            height: height,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Constants.blackcolor.withOpacity(.03),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Constants.blackcolor.withOpacity(.1)),
            ),
            child: TextField(
                keyboardType: TextInputType.text,
                maxLines: null,
                enabled: enabled,
                onChanged: onchanged,
                autofocus: true,
                controller: textEditingController,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: details
                    ? InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          bottom: 8,
                          top: 10,
                        ),
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(color: Constants.graycolor),
                      )
                    : InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          bottom: 8,
                        ),
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(color: Constants.graycolor)))),
      ],
    );
  }
}
