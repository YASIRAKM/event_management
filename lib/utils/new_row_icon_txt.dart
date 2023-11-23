import 'package:flutter/material.dart';

class NewRowICOnTxtWidget extends StatelessWidget {
  final double w;
  final double h;
  final IconData ics;
  final String txt;
  final Color clr;
  final TextStyle txtstl;
  const NewRowICOnTxtWidget({
    super.key, required this.ics, required this.txt, required this.clr, required this.txtstl, required this.w, required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: w,height: h,
      child: Row(children: [
        Icon(ics,color: clr),
       const Padding(padding: EdgeInsets.only(left: 20)),
        Expanded(child: Text(txt,style: txtstl)),
      ],),
    );
  }
}