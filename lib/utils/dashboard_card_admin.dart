
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';

class DashBoardCArd extends StatelessWidget {
  final IconData icos;
  final String title;
  final dynamic route;
  final Color clrs;

  const DashBoardCArd({
    super.key,
    required this.icos,
    required this.title,
    required this.route, required this.clrs,
  });

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => route));
      },
      child: Card(
        elevation: .3,
        margin: EdgeInsets.all(ht * .03),
        child: Padding(
          padding: EdgeInsets.only(left:ht * .01,right: ht*.01,top: ht*.03),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  icos,
                  size: ht * .08,
                  color:clrs,
                ),
                SizedBox(
                  height: ht * .02,
                ),
                Expanded(child: Text(title,style: MyTextStyle().dashText,))
              ]),
        ),
      ),
    );
  }
}