import 'package:flutter/material.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import '../constants/text_style_constant.dart';

class NewDetailedText extends StatelessWidget {
  const NewDetailedText({
    super.key,
    required this.wt,
    required this.ht,
    required this.title,
    required this.val,
  });

  final String title;
  final String val;


  final double wt;
  final double ht;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "$title:",
        style: MyTextStyle().dashText,
      ),
      Container(
        width: wt * .7,
        child: Card(

            child: Padding(
              padding: EdgeInsets.only(
                  left: wt * .05, top: ht * .01, bottom: ht * .01),
              child: Text(
                val,
                style: MyTextStyle().txtstyle4,
              ),
            )),
      )
    ]);
  }
}
