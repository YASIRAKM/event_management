
import 'package:flutter/material.dart';

import '../constants/text_style_constant.dart';

class TxtField extends StatelessWidget {
  final String title;
  final TextEditingController cntrlr;
  final TextInputType kybrd;
  final double h;
  final double w;
  final IconData ics;
  final bool upd;
 final VoidCallback suffixpress;
  const TxtField({super.key, required this.title, required this.cntrlr, required this.kybrd, required this.h, required this.w, required this.ics, required this.upd,required this.suffixpress});

  @override
  Widget build(BuildContext context) {
    return Container(height: h,width: w,decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: TextFormField(
        keyboardType: kybrd,
        decoration: InputDecoration(prefixIcon: Icon(ics),suffixIcon:upd?IconButton(icon:const Icon(Icons.update,size: 20,) , onPressed:suffixpress ,):null,border: InputBorder.none,labelText: title,labelStyle: MyTextStyle().eventTitleText,),
        controller: cntrlr,
        validator: (value) {
          if (value!.isEmpty) {
            return 'please fill';
          }
          return null;
        },
      ),
    );
  }
}