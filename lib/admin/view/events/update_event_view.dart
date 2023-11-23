import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:eventmanagement/admin/controller/add_image.dart';
import 'package:eventmanagement/admin/controller/admin_creeating_updating_firebase.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/new_txtfield.dart';
import '../../../utils/new_container_button.dart';
import '../../../constants/text_style_constant.dart';
import '../../model/addphoto.dart';
import '../admin_home_view.dart';

class UpdateEventView extends StatelessWidget {
  final String docId;

  UpdateEventView({super.key, required this.docId});


  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addTitleController = TextEditingController();
  TextEditingController addEscController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: const CommonAppbar(
            txt: 'Update Event',
            drawericon: CupertinoIcons.back,
            clrs: MyColorConst.color1),
        // drawer: Drawers(),
        body: Consumer2<AddPhoto,AddUpdate>(
          builder: (context, addPhoto,updateEvent, child) {
            return Padding(
              padding: EdgeInsets.only(top: ht * .06, left: wt * .15),
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
                            final preFe = await FirebaseFirestore.instance
                                .collection("Event")
                                .doc(docId);
                            DocumentSnapshot<Map<String, dynamic>> querySnapshot =
                                await preFe.get();
                            List<String> resultList = [];
                            Map<String, dynamic> data = querySnapshot.data()!;
                            if (data.containsKey('URLlist')) {
                              List<dynamic> dataList = data['URLlist'];
                              List<String> resultList =
                                  dataList.map((item) => item.toString()).toList();

                            }
                            final db = await SharedPreferences.getInstance();
                            var url = db.getString('url');
                            resultList.add(url!);

                            updateEvent.updateData("Event", docId,{
                              "URLlist": resultList,
                            } );

                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: ht * .03),
                  TxtField(
                      title: 'Title',
                      cntrlr: titleController,
                      kybrd: TextInputType.text,
                      h: ht * .08,
                      w: wt * .7,
                      ics: Icons.title,
                      upd: true,
                      suffixpress: () async {
                        updateEvent.updateData("Event", docId,{
                          "Title": titleController.text,
                        } );
                      }
                        ),
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
                        updateEvent.updateData("Event",docId,
                          {"price": priceController.text}
                         );

                      }),
                  SizedBox(height: ht * .03),
                  TxtField(
                      title: 'Description',
                      cntrlr: descController,
                      kybrd: TextInputType.text,
                      h: ht * .2,
                      w: wt * .7,
                      ics: Icons.description,
                      upd: true,
                      suffixpress: () async {
                        updateEvent.updateData("Event", docId,
                            {"Description": descController.text}
                        );

                      }),
                ],
              ),
            );
          }
        ));
  }
}

class NewRawWidget extends StatelessWidget {
  final String title;
  final dynamic cntrlr;

  const NewRawWidget({
    super.key,
    required this.title,
    required this.cntrlr,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 300,
      height: 200,
      child: Row(
        children: [
          Text(title),
          SizedBox(
              height: 200,
              width: 200,
              child: TextField(
                decoration: const InputDecoration(border: InputBorder.none),
                controller: cntrlr,
              ))
        ],
      ),
    );
  }
}
