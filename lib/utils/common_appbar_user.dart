import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:eventmanagement/login_controller.dart';
import 'package:eventmanagement/main.dart';
import 'package:eventmanagement/user/controller/userid_controller.dart';
import 'package:eventmanagement/utils/new_container_button.dart';
import 'package:eventmanagement/utils/new_txtfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:eventmanagement/user/controller/value_changing_controller.dart';

import 'package:eventmanagement/user/view/review_view_user.dart';
import 'package:shared_preferences/shared_preferences.dart';



// import '../main.dart';

class CommonAppBarUser extends StatelessWidget implements PreferredSizeWidget {
  final String title1;
  final bool clr;
  // final VoidCallback onPress;

  const CommonAppBarUser(
      {super.key,
      required this.title1,
      required this.clr,
      // required this.onPress
      });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<UserBasicController>(context);
    final userIdController = Provider.of<UserIdController>(context);
    final logoutController = Provider.of<LoginController>(context);
    final TextEditingController reviewController = TextEditingController();
    final ht =MediaQuery.sizeOf(context).height;
    final wt =MediaQuery.sizeOf(context).width;
    return AppBar(
      bottomOpacity: 10,
      flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: clr
                  ? LinearGradient(colors: [
                      MyColorConst().userAppbargradient1,
                      MyColorConst().userAppbargradient2,
                      MyColorConst().userAppbargradient3,
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight)
                  : null)),
      title: Text(
        title1,
        style: MyTextStyle().userappbarstyle,
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  child: TextButton(
                onPressed: ()async{
                  final sh = await SharedPreferences.getInstance();
                  sh.setBool("log", false);
                  logoutController.logout();

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const MyHomePage()));
                }, child: const Text("Logout"),
                //    ()async{
                //    logouController.logout();
                //    // Logincntrlr().logout();
                // Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>MyHomePage()));
                //   }
              )),
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Card(elevation: 0,margin: EdgeInsets.only(top: ht*.23,left: wt*.15,right: wt*.15,bottom: ht*.23),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RatingBar.builder(
                                  allowHalfRating: true,
                                  itemBuilder: (context, index) {
                                    return  Icon(
                                      Icons.star,
                                      color: MyColorConst().ratingColor,
                                    );
                                  },
                                  onRatingUpdate: (value) {
                                    controller.updateRate(value);
                                  },itemSize: 25,unratedColor: MyColorConst().unRatedColor,
                                ),
                                TxtField(
                                    title: 'Review',
                                    cntrlr: reviewController,
                                    kybrd: TextInputType.text,
                                    h:ht * .25,
                                    w:wt* .55,
                                    ics: Icons.rate_review,
                                    upd: false,
                                    suffixpress: () {}),

                                elevatedButton(
                                    hght:
                                        ht * .05,
                                    wdth:
                                        wt * .35,
                                    cColor: MyColorConst.color1,
                                    r2: 0,
                                    r1: 0,
                                    r3: 0,
                                    r4: 0,
                                    onpressed: () async{
                                      await FirebaseFirestore.instance.collection("Review").add({"rating":controller.rate.toDouble(),
                                      "review":reviewController.text,
                                      "userid":userIdController.id.toString()});
                                      reviewController.clear();
                                      controller.rate==0;
                                    },
                                    bColor: MyColorConst.color1,
                                    txt: 'SUBMIT',
                                    txtstyle: MyTextStyle().txtstyle1),
                                elevatedButton(
                                    hght:
                                        ht * .05,
                                    wdth:
                                       wt * .35,
                                    cColor: MyColorConst.color1,
                                    r2: 0,
                                    r1: 0,
                                    r3: 0,
                                    r4: 0,
                                    onpressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const RevViewUser()));
                                    },
                                    bColor: MyColorConst.color1,
                                    txt: 'REVIEWS',
                                    txtstyle: MyTextStyle().txtstyle1),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Review")),
              )
            ];
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
