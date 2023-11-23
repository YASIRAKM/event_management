import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils//common_appbar_admin.dart';
import 'package:eventmanagement/admin/controller/add_image.dart';
import 'package:eventmanagement/admin/controller/admin_creeating_updating_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eventmanagement/constants/color_constants.dart';

import '../../../utils/new_txtfield.dart';
import '../../../utils/new_container_button.dart';
import '../../../constants/text_style_constant.dart';



class UpdateAdminService extends StatelessWidget {
  final String docId;

  UpdateAdminService({super.key, required this.docId});

 final  TextEditingController titleController = TextEditingController();
 final  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const CommonAppbar(
          txt: 'Update Service',
          drawericon: CupertinoIcons.back,
          clrs: MyColorConst.color1),
      body: Consumer2<AddPhoto, AddUpdate>(
          builder: (context, addPhoto, updateService, child) {
        return Padding(
          padding: EdgeInsets.only(top: ht * .15, left: wt * .15),
          child: Column(
            children: [
              Container(
                width: wt * .7,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(0)),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          addPhoto.uploadImageC();
                        },
                        icon: Icon(
                          Icons.update,
                          size: ht * .15,
                          color: MyColorConst.txt1clr,
                        )),
                   const Text("Click to update image",
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
                      txt: 'update',
                      txtstyle: MyTextStyle().eventdesctext,
                      onpressed: () async {
                        final db = await SharedPreferences.getInstance();
                        var url = db.getString('url');
                        updateService
                            .updateData("Serrvice", docId, {"URL": url});
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: ht * .03),
              TxtField(
                  title: 'Service',
                  cntrlr: titleController,
                  kybrd: TextInputType.text,
                  h: ht * .08,
                  w: wt * .7,
                  ics: Icons.title,
                  upd: true,
                  suffixpress: () async {
                    updateService.updateData("Services", docId, {
                      "Service": titleController.text,
                    });
                  }),
              SizedBox(height: ht * .03),
              TxtField(
                  title: 'Price',
                  cntrlr: priceController,
                  kybrd: TextInputType.number,
                  h: ht * .08,
                  w: wt * .7,
                  ics: Icons.price_change_outlined,
                  upd: true,
                  suffixpress: () async {
                    updateService.updateData("Services", docId,
                        {"Price": double.parse(priceController.text)});
                  }),
              SizedBox(height: ht * .03),

            ],
          ),
        );
      }),
    );
  }
}
