import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';

class TextFrmFieldWithPrefixIcon extends StatelessWidget {
  final TextEditingController cntlr;
  final String lbltxt;
  final IconData ics;
  final double ht;
  final double wt;
  final double t;
  final TextInputType ktypr;

  const TextFrmFieldWithPrefixIcon({
    super.key,
    required this.cntlr,
    required this.lbltxt,
    required this.ics,
    required this.ht,
    required this.wt,
    required this.t,
    required this.ktypr,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: t,
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color:MyColorConst().backgroundColor),
            borderRadius: BorderRadius.circular(5)),
        height: ht,
        width: wt,
        child: TextFormField(
          keyboardType: ktypr,
          controller: cntlr,
          decoration: InputDecoration(labelStyle: MyTextStyle().txtstyle2,
              labelText: lbltxt,
              border: InputBorder.none,
              prefixIcon: Icon(ics,color: MyColorConst.color1,)),
        ),
      ),
    );
  }
}

class NewElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPrss;
  final double t;

  const NewElevatedButton(
      {super.key, required this.title, required this.onPrss, required this.t});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: t),
      child: ElevatedButton(onPressed: onPrss, child: Text(title)),
    );
  }
}