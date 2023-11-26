import 'package:eventmanagement/admin/view/Users/users_view.dart';
import 'package:eventmanagement/admin/view/review_view.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
import '../../utils/common_appbar_admin.dart';
import '../../constants/color_constants.dart';
import 'complaint_view_admin.dart';
import 'events/even_t.dart';
import 'Service/service.dart';
import 'admin_dash_view.dart';
import 'admin_profile_add.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: Drawers(),
      body: AdminDashView(),
    );
  }
}

class NewWidget extends StatelessWidget {
  final IconData icos;
  final String title;
  final dynamic route;

  const NewWidget({
    super.key,
    required this.icos,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => route));
        },
        child: Column(
          children: [
            ListTile(
                leading: Icon(
                  icos,
                  color: MyColorConst.color1,
                ),
                title: Text(
                  title,
                  style: MyTextStyle().drawerText,
                )),
          ],
        ));
  }
}

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    final wt = MediaQuery.sizeOf(context).width;
    return Drawer(
      backgroundColor: MyColorConst.color2,
      width: wt * .7,
      child: ListView(children: [
        DrawerHeader(
            child: Padding(
          padding:
              EdgeInsets.only(left: wt * .02, right: wt * .1, top: wt * .1),
          child: Column(
            children: [
              const CircleAvatar(),
              Text(
                "ADMIN",
                style: MyTextStyle().drawerHeaderText,
              )
            ],
          ),
        )),
        const NewWidget(
          icos: Icons.dashboard,
          title: 'Dashboard',
          route: AdminDashView(),
        ),
        const Divider(
          thickness: .5,
        ),
        const NewWidget(
          icos: FontAwesomeIcons.users,
          title: 'Users',
          route: Users(),
        ),
        const Divider(
          thickness: .5,
        ),
        const NewWidget(
          icos: Icons.rate_review_rounded,
          title: 'Events',
          route: Event(),
        ),
        const Divider(
          thickness: .5,
        ),
        const NewWidget(
          icos: Icons.preview,
          title: 'Complaints',
          route: ComplaintViewAdmin(),
        ),
        const Divider(
          thickness: .5,
        ),
        const NewWidget(
          icos: FontAwesomeIcons.addressCard,
          title: 'Profile',
          route: AdminProfile(),
        ),
        const Divider(
          thickness: .5,
        ),
        const NewWidget(
          icos: Icons.rate_review,
          title: 'Reviews',
          route: ReviewViewAdmin(),

        ),
        Padding(
          padding:  EdgeInsets.only(left: wt * .05, right: wt * .1),
          child: Row(children: [const Icon(Icons.logout,color: MyColorConst.color1, ), TextButton(onPressed: ()async{
            final navigator = Navigator.of(context);
            await FirebaseAuth.instance.signOut();
            navigator.pushReplacement(MaterialPageRoute(builder: (_)=>const MyHomePage()));


          }, child: Text("Logout",style: MyTextStyle().drawerText,))],),
        )
      ]),
    );
  }
}
