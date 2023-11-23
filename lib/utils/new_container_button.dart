
import 'package:flutter/material.dart';

class elevatedButton extends StatelessWidget {
  final String txt;
  final double hght;
  final double wdth;
  final double r2;
  final double r1;
  final double r3;
  final double r4;
  final Color cColor;
  final Color bColor;
  final TextStyle txtstyle;
  final VoidCallback? onpressed;

  const elevatedButton({
    super.key,
    required this.hght,
    required this.wdth,
    required this.cColor,
    required this.r2,
    required this.r1,
    required this.r3,
    required this.r4,
    required this.onpressed,
    required this.bColor,
    required this.txt, required this.txtstyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wdth,
      height: hght,
      decoration: BoxDecoration(
        color: cColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(r3),
            topRight: Radius.circular(r4),
            topLeft: Radius.circular(r1),
            bottomRight: Radius.circular(r2)),
      ),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(bColor),
          ),
          onPressed: onpressed,
          child: Text(txt,style:txtstyle ),)
    );
  }
}
