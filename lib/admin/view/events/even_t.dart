
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../admin_home_view.dart';

import 'event_add.dart';
import 'event_view.dart';


class Event extends StatelessWidget {
  const Event({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;

    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          backgroundColor: MyColorConst().Card1,
          shape: const CircleBorder(side: BorderSide.none),
          child: const Icon(FontAwesomeIcons.plus, color: MyColorConst.color1),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => EventAdd()));
          }),
      drawer: const Drawers(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Column(
        children: [
          SizedBox(height: ht, child: const EventView()),
        ],
      ),
    );
  }
}
