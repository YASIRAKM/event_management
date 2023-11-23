import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:eventmanagement/admin/controller/add_image.dart';
import 'package:eventmanagement/admin/controller/admin_creeating_updating_firebase.dart';
import 'package:eventmanagement/admin/model/addphoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/new_txtfield.dart';
import '../../../utils/new_container_button.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/text_style_constant.dart';

class AddService extends StatelessWidget {
  AddService({super.key});

  TextEditingController serviceController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const CommonAppbar(
          txt: 'Add Service',
          drawericon: CupertinoIcons.back,
          clrs: MyColorConst.color1),
      body: Consumer2<AddPhoto, AddUpdate>(
          builder: (context, addPhoto, addData, child) {
        return Padding(
          padding:
              EdgeInsets.only(left: wt * .07, right: wt * .07, top: ht * .1),
          child: ListView(
            children: [
              Container(
                height: ht * .25,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Card(
                    child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_rounded,
                      size: ht * .15,
                      color: MyColorConst.txt1clr,
                    ),
                    const Text("Click and upload image",
                        style: TextStyle(color: MyColorConst.primaryColor)),
                    elevatedButton(
                      hght: ht * .05,
                      wdth: wt * .3,
                      bColor: MyColorConst.color1,
                      cColor: MyColorConst.color1,
                      r1: 0,
                      r2: 0,
                      r3: 0,
                      r4: 0,
                      txt: 'upload',
                      txtstyle: MyTextStyle().eventdesctext,
                      onpressed: () {
                        addPhoto.uploadImageC();
                      },
                    )
                  ],
                )),
              ),
              SizedBox(
                height: ht * .03,
              ),
              TxtField(
                  title: 'Service',
                  cntrlr: serviceController,
                  kybrd: TextInputType.text,
                  h: ht * .08,
                  w: wt * .03,
                  ics: Icons.title,
                  upd: false,
                  suffixpress: () {}),
              SizedBox(height: ht * .03),
              TxtField(
                  title: 'Price',
                  cntrlr: priceController,
                  kybrd: TextInputType.number,
                  h: ht * .08,
                  w: wt * .03,
                  ics: Icons.price_change_outlined,
                  upd: false,
                  suffixpress: () {}),
              SizedBox(
                height: ht * .03,
              ),
              elevatedButton(
                hght: ht * .05,
                wdth: wt * .3,
                cColor: MyColorConst.color2,
                r2: 1,
                r1: 1,
                r3: 1,
                r4: 1,
                bColor: MyColorConst.color2,
                txt: 'Add  Event',
                txtstyle: MyTextStyle().txtstyle2,
                onpressed: () async {
                  final db = await SharedPreferences.getInstance();
                  await db.getString('url');
                  addData.addData("Services", {
                    "URL": db.getString("url"),
                    "Service": serviceController.text,
                    "Price": double.parse(priceController.text)
                  });
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
