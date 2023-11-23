import 'package:flutter/material.dart';

import '/constants/text_style_constant.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String txt;
  final IconData drawericon;
  final Color clrs;


  const CommonAppbar({super.key, required this.txt, required this.drawericon, required this.clrs});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        txt,
        style: MyTextStyle().appBarText,
      ),

      backgroundColor:clrs ,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>const Size.fromHeight(kToolbarHeight);
}
