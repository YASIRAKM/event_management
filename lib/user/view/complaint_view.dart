import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils/new_container_button.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:eventmanagement/user/controller/userid_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/new_txtfield.dart';
import '../../utils/new_row_icon_txt.dart';

import 'auth_view.dart';

class ComplaintView extends StatelessWidget{
  const ComplaintView({super.key});





  @override
  Widget build(BuildContext context) {
   final  TextEditingController subjController = TextEditingController();
   final  TextEditingController contentController = TextEditingController();
    late String name;
    late String mail;
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only( top: ht*.04,left: wt * .08, right: wt * .08,bottom: ht*.1),
        child: Card(
          elevation: 0,
          child: ListView(
            children: [
              Text("Register complaint here:",style: MyTextStyle().imgetitle),
              const Divider(),
              SizedBox(height: ht*.02,),
             Consumer<UserIdController>(
                builder: (context, userController, child) {

                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .where("Id" "==" "${userController.id}"  )
                          .snapshots(),
                      builder: (context, snapshot) {
                        Map<String, dynamic> data =
                            snapshot.data!.docs.first.data();

                        name = data["Name"];
                        mail = data["E mail"];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NewRowICOnTxtWidget(
                              ics: Icons.person,
                              clr: MyColorConst.color1,
                              txtstl: MyTextStyle().cmplnttxt2,
                              txt: name, w: wt*.8, h: ht*.05,
                            ),
                            SizedBox(
                              height: ht*.03,
                            ),
                            NewRowICOnTxtWidget(
                              ics: Icons.mail,
                              clr: MyColorConst.color1,
                              txtstl: MyTextStyle().cmplnttxt2,
                              txt: mail, w: wt*.9, h: ht*.05,
                            ),
                          ],
                        );
                      });
                }
              ),
              Padding(
                padding: EdgeInsets.only(top: ht*.03),
                child: Column(
                  children: [
                    TxtField(
                      title: 'Subject',
                      upd: false,
                      ics: Icons.subject,
                      cntrlr: subjController,
                      h: ht * .07,
                      suffixpress: () {},
                      kybrd: TextInputType.text,
                      w: wt * .9,
                    ),
                    SizedBox(
                      height: ht * .03,
                    ),
                    TxtField(
                      title: 'Content',
                      upd: false,
                      ics: Icons.content_paste,
                      cntrlr: contentController,
                      h: ht * .2,
                      suffixpress: () {},
                      kybrd: TextInputType.text,
                      w: wt * .9,
                    ),
                    SizedBox(height: ht * .03),
                    elevatedButton(
                        onpressed: () async {
                          await FirebaseFirestore.instance
                              .collection("Complaint")
                              .add({
                            "Name": name,
                            "Mail": mail,
                            "Subject":subjController.text,
                            "Content": contentController.text
                          });
                          Fluttertoast.showToast(
                              msg: "Mail sent to 'evant@gmail.com'",
                              gravity: ToastGravity.CENTER);
                        },
                        txt: 'Register Complaint',
                        r1: 0,
                        r4: 0,
                        r3: 0,
                        r2: 0,
                        cColor: MyColorConst().userAppbargradient2,
                        bColor: MyColorConst().userAppbargradient2,
                        wdth: wt * .58,
                        hght: ht * .05,
                        txtstyle: MyTextStyle().txtstyle3),
                  ],
                ),
              ),
             const  Divider(),
              Padding(
                padding:  EdgeInsets.only(top: ht*.01,left: wt*.22),
                child: Text("Connect with us",style: MyTextStyle().txtstyle4),
              ),
              Padding(
                padding:  EdgeInsets.only(left: wt*.1,right: wt*.1,top: ht*.01),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.outlined(onPressed: (){}, icon:const Icon(FontAwesomeIcons.facebook),color: MyColorConst().userAppbargradient1),
                    IconButton.outlined(onPressed: (){}, icon:const Icon(FontAwesomeIcons.instagram),color: MyColorConst().userAppbargradient1),
                    IconButton.outlined(onPressed: (){}, icon:const Icon(FontAwesomeIcons.twitter),color: MyColorConst().userAppbargradient1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
