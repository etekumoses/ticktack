import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  final Function press;

  const ButtonWidget({Key key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: ShapeDecoration(
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        color: Constants.primarycolor,
      ),
      child: Material(
        color: Constants.primarycolor,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: InkWell(
          onTap: press,
          child: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                'Save'.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Constants.whitecolor,fontFamily: Constants.POPPINS,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
