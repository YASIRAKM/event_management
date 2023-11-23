

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../../constants/color_constants.dart';

import '../../../utils/common_appbar_admin.dart';
import '../admin_home_view.dart';

import 'add_services.dart';
import 'view_services.dart';

class Service extends StatelessWidget {
  const Service({super.key});


  @override
  Widget build(BuildContext context) {
    final ht=  MediaQuery.sizeOf(context).height;

    return Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(shape: const CircleBorder(),onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (_)=>AddService()));
      },backgroundColor: MyColorConst().Card1,child: const Icon(FontAwesomeIcons.plus,color: MyColorConst.color1,)),
      appBar:const CommonAppbar(txt: 'Services', drawericon: Icons.menu, clrs: MyColorConst.color1),drawer:const  Drawers(),
      body:
      Padding(
        padding: EdgeInsets.only(top: ht*.04),
        child: SizedBox(height:ht,child:const ServsView()),
      ) ,
    );
  }
}
