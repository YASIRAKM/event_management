import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/admin/view/events/update_event_view.dart';
import 'package:eventmanagement/admin/view/Users/users_view.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../utils/common_appbar_admin.dart';
import '../../utils/dashboard_card_admin.dart';
 import 'booked_view/booked_view.dart';
import 'admin_home_view.dart';
import 'events/even_t.dart';
import 'Service/service.dart';


class AdminDashView extends StatelessWidget {
  const AdminDashView({super.key});

  @override
  Widget build(BuildContext context) {
    // DateTime   Dates = DateTime.now();
    String format =DateFormat("dd-MM-yyyy").format(DateTime.now());
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
     num length;
    return Scaffold(
      appBar:  const CommonAppbar(txt: 'Dashboard', drawericon: Icons.menu, clrs: MyColorConst.color1, ),
      drawer:const  Drawers(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: ht * .08, left: wt * .08),
            child: SizedBox(
              height: ht * .11,
              width: wt*.9,
              child: Row(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Booking")
                          .snapshots(),
                      builder: (context, snapshot) {
                         length = snapshot.data!.docs.length / 100;

                        return Column(
                          children: [
                            Text("Total Booking",style: MyTextStyle().dashText),
                            CircularProgressIndicator(
                              value: length.toDouble(),
                              semanticsValue: length.toString(),
                              semanticsLabel: length.toString(),
                              color: Colors.red,
                              backgroundColor: Colors.blue,
                            ),
                            Text((length * 100).toInt().toString(),style: MyTextStyle().dashText,),
                          ],
                        );
                      }),
                  SizedBox(
                    width: wt * .25,
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Booking").orderBy("date")
                          .where("date" ">=" "$format" )
                          .snapshots(),
                      builder: (context, snapshot) {
                        num length1 = snapshot.data!.docs.length /100;

                        return Column(
                          children: [
                            Text("Pending Booking",style: MyTextStyle().dashText),
                            CircularProgressIndicator(
                              value: length1.toDouble(),
                              semanticsValue: length1.toString(),
                              semanticsLabel: length1.toString(),
                              color: Colors.red,
                              backgroundColor: Colors.blue,
                            ),
                            Text((length1 * 100).toInt().toString(),style: MyTextStyle().dashText,),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ht * .08),
            child:  SizedBox(
              height: ht * .57,
              child:   GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                  children: const [
                  DashBoardCArd(
                    icos: Icons.event,
                    title: ' Events',
                    route:Event(), clrs: MyColorConst.color1,
                  ),
                  DashBoardCArd(
                    icos: FontAwesomeIcons.cakeCandles,
                    title: ' Services',
                    route: Service(), clrs: MyColorConst.color1,
                  ),
                  DashBoardCArd(
                    icos: FontAwesomeIcons.user,
                    title: 'Users',
                    route: Users(), clrs: MyColorConst.color1,
                  ),
                  DashBoardCArd(
                    icos: Icons.event_available,
                    title: 'Booked events',
                    route: BookedView(), clrs: MyColorConst.color1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


