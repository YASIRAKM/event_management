import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:eventmanagement/admin/controller/add_image.dart';
import 'package:eventmanagement/admin/model/addphoto.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/new_txtfield.dart';
import '../../../utils/new_container_button.dart';

import '../../controller/admin_creeating_updating_firebase.dart';
import '../admin_home_view.dart';

class EventAdd extends StatelessWidget {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double ht = MediaQuery.sizeOf(context).height;
    final double wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      drawer:const  Drawers(),
      appBar: const CommonAppbar(
          txt: 'Add Event', drawericon: Icons.menu, clrs: MyColorConst.color1),
      body: Padding(
        padding:
            EdgeInsets.only(left: wt * .07, right: wt * .07, top: ht * .02),
        child: Consumer2<AddPhoto, AddUpdate>(
            builder: (context, addPhoto, addEvent, child) {
          return ListView(
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
                        addPhoto.pickImages();
                        addPhoto.uploadImages();
                      },
                    )
                  ],
                )),
              ),
              SizedBox(
                height: ht * .03,
              ),
              TxtField(
                  title: 'Title',
                  cntrlr: titleController,
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
              SizedBox(height: ht * .03),
              TxtField(
                title: 'Description',
                cntrlr: descriptionController,
                kybrd: TextInputType.text,
                h: ht * .2,
                w: wt * .03,
                ics: Icons.description,
                upd: false,
                suffixpress: () {},
              ),
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

                  addEvent.addData("Event", {
                    "URLlist": addPhoto.imageUrls,
                    'Title': titleController.text,
                    'Description': descriptionController.text,
                    'price': priceController.text
                  });
                  Fluttertoast.showToast(msg: "Event Added Successfully");
                  titleController.clear();
                  descriptionController.clear();
                  priceController.clear();
                  Navigator.pop(context);
                
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
